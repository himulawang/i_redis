part of lib_test;

testPubSub(IRedis handler1, IRedis handler2) {

  group('Pub/Sub',() {

    group('subscribe /unsubscribe / publish', () {

      test('subscribe without onDone', () {

        handler1.subscribe('foo', expectAsync((message) {
          expect(message, 'test...');
          handler1.unsubscribe('foo')
          .then(expectAsync((_) {
            expect(handler1.subOnData.length, 0);
            expect(handler1.subOnDone.length, 0);
            expect(handler1.pubOnSubscribe.length, 0);
            expect(handler1.pubOnUnsubscribe.length, 0);
          }));
        }))
        .then(expectAsync((result) {
          handler2.publish('foo', 'test...');
        }));

      });

      test('with onDone', () {

        handler1.subscribe('foo', expectAsync((message) {
          expect(message, 'test...');
          handler1.unsubscribe('foo')
          .then(expectAsync((_) {
            expect(true, true);
          }));
        }), onDone: expectAsync(() {
          // test this function be executed
          expect(true, true);
        }))
        .then(expectAsync((result) {
          handler2.publish('foo', 'test...');
        }));

      });

      test('resubscribe will execute onDone', () {

        handler1.subscribe('foo', (message) {
        }, onDone: expectAsync(() {
          // test this function be executed
          expect(true, true);
        }))
        .then(expectAsync((result) => handler1.subscribe('foo', (message) {})))
        .then(expectAsync((_) => handler1.unsubscribe('foo')))
        .then(expectAsync((_) => expect(handler1.MODE_PUBSUB, false)));

      });

      test('unsubscribe a non-listening channel', () {

        expect(() {
          handler1.unsubscribe('foo');
        }, throwsA(predicate((e) => e is IRedisException)));

      });

    });

    group('psubscribe /punsubscribe / publish', () {

      test('psubscribe without onDone', () {

        handler1.psubscribe('fo?', expectAsync((channel, message) {
          expect(channel, 'foo');
          expect(message, 'test...');
          handler1.punsubscribe('fo?')
          .then(expectAsync((_) {
            expect(handler1.psubOnData.length, 0);
            expect(handler1.psubOnDone.length, 0);
            expect(handler1.pubOnPsubscribe.length, 0);
            expect(handler1.pubOnPunsubscribe.length, 0);
          }));
        }))
        .then(expectAsync((result) {
          handler2.publish('foo', 'test...');
        }));

      });

      test('with onDone', () {

        handler1.psubscribe('fo?', expectAsync((channel, message) {
          expect(message, 'test...');
          handler1.punsubscribe('fo?')
          .then(expectAsync((_) {
            expect(true, true);
          }));
        }), onDone: expectAsync(() {
          // test this function be executed
          expect(true, true);
        }))
        .then(expectAsync((result) {
          handler2.publish('foo', 'test...');
        }));

      });

      test('repsubscribe will execute onDone', () {

        handler1.psubscribe('fo?', (channel, message) {
        }, onDone: expectAsync(() {
          // test this function be executed
          expect(true, true);
        }))
        .then(expectAsync((result) => handler1.psubscribe('fo?', (message) {})))
        .then(expectAsync((_) => handler1.punsubscribe('fo?')))
        .then(expectAsync((_) => expect(handler1.MODE_PUBSUB, false)));

      });

      test('punsubscribe a non-listening channel', () {

        expect(() {
          handler1.punsubscribe('fo?');
        }, throwsA(predicate((e) => e is IRedisException)));

      });

    });

    group('pubsub', () {

      test('invalid type', () {

        expect(() {
          handler1.pubsub('invalid');
        }, throwsA(predicate((e) => e is IRedisException)));

      });

      test('channels', () {
        handler1.subscribe('foo', (message) {
        })
        .then(expectAsync((result) {
          return handler2.pubsub('channels', 'fo?');
        }))
        .then(expectAsync((result) {
          expect(result, ['foo']);
        }));

      });

      test('numsub single channel', () {

        handler1.subscribe('bar', (message) {
        })
        .then(expectAsync((result) {
          return handler2.pubsub('numsub', 'bar');
        }))
        .then(expectAsync((result) {
          expect(result, ['bar', '1']);
        }));

      });

      test('numsub multiple channels', () {

        handler1.subscribe('2000', (message) {
        })
        .then(expectAsync((result) {
          return handler2.pubsub('numsub', ['foo', 'bar', '2000']);
        }))
        .then(expectAsync((result) {
          expect(result, ['foo', '1', 'bar', '1', '2000', '1']);
          List waitList = [];
          waitList.add(handler1.unsubscribe('foo'));
          waitList.add(handler1.unsubscribe('bar'));
          waitList.add(handler1.unsubscribe('2000'));

          Future.wait(waitList).then(expectAsync((_) {}));
        }));

      });

      test('numpat', () {

        handler1.psubscribe('fo?', (message) {
        })
        .then(expectAsync((result) {
          return handler2.pubsub('numpat');
        }))
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

    });

  });

}
