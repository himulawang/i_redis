part of lib_test;

testKey(IRedis handler1, IRedis handler2) {

  group('Key',() {

    group('del', () {

      setUp(() {
        handler1.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
        handler2.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('single key', () {

        handler1.mset({'testDel1': 'value1'})
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.del('testDel1');
        }))
        .then(expectAsync((result) {
          expect(result, 1);
        }))
        ;

      });

      setUp(() {});

      test('multiple keys', () {

        handler1.mset({'testDel1': 'value1', 'testDel2': 'value2', 'testDel3': 'value3' })
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.del(['testDel1', 'testDel2', 'testDel3', 'testDel4']);
        }))
        .then(expectAsync((result) {
          expect(result, 3);
        }))
        ;

      });

    });

    group('migrate', () {

      test('migrate', () {

        handler1.mset({'testMigrate': 'value'})
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.migrate(handler2.host, handler2.port, 'testMigrate',
                                  0, 2000);
        }))
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler2.get('testMigrate');
        }))
        .then(expectAsync((result) {
          expect(result, 'value');
        }));

      });

    });

    group('pttl', () {

      test('pttl', () {

        handler1.setex('testPttl', 2000, 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.pttl('testPttl');
        }))
        .then(expectAsync((result) {
          expect(result is int, true);
        }));

      });

    });

    group('ttl', () {

      test('ttl', () {

        handler1.setex('testTtl', 2000, 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.ttl('testTtl');
        }))
        .then(expectAsync((result) {
          expect(result is int, true);
        }));

      });

    });

    group('dump', () {

      test('dump', () {

        handler1.set('testDump', 10)
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.dump('testDump');
        }))
        .then(expectAsync((result) {
          expect(result is String, true);
        }));

      });

    });

    group('move', () {

      setUp(() {
        handler1.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('move', () {

        IRedis handlerAnother = new IRedis(db: 1);
        handlerAnother.connect()
        .then((result) {
          return handlerAnother.flushdb();
        })
        .then(expectAsync((result) {
          return handler1.set('testMove', 'value');
        }))
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.move('testMove', 1);
        }))
        .then(expectAsync((result) {
          expect(result, 1);
          return handlerAnother.close();
        }));

      });

      setUp(() {});

    });

    group('randomkey', () {

      setUp(() {
        handler1.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('randomkey', () {

        handler1.randomkey()
        .then(expectAsync((result) {
          expect(result, null);
        }));

      });

      setUp(() {});

    });

    group('type', () {

      test('type', () {

        handler1.hset('testType', 'field', 'value')
        .then(expectAsync((result) {
          expect(result, 1);
          return handler1.type('testType');
        }))
        .then(expectAsync((result) {
          expect(result, 'hash');
        }));

      });

    });

    group('exists', () {

      test('exists', () {

        handler1.set('testExists', 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.exists('testExists');
        }))
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

    });

    group('object', () {

      test('object', () {

        handler1.set('testObject', 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.object('refcount', 'testObject');
        }))
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      test('invalid param', () {

        expect(
            () => handler1.object('invalid', 'testObject'),
            throwsA(predicate((e) => e is IRedisException))
        );

      });

    });

    group('rename', () {

      test('rename', () {

        handler1.set('testRename', 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.rename('testRename', 'testRenamed');
        }))
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('scan', () {

      setUp(() {

        handler1.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('2 parameters', () {

        handler1.mset({
            'key1': 'value1',
            'key2': 'value2',
            'key3': 'value3',
            'key4': 'value4',
            'key5': 'value5',
            'key6': 'value6',
            'key7': 'value7',
            'key8': 'value8',
        })
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.scan(0);
        }))
        .then(expectAsync((result) {
          expect(result[0], '0');
          expect(result[1].length, 8);
          expect(result[1].contains('key1'), true);
          expect(result[1].contains('key2'), true);
          expect(result[1].contains('key3'), true);
          expect(result[1].contains('key4'), true);
          expect(result[1].contains('key5'), true);
          expect(result[1].contains('key6'), true);
          expect(result[1].contains('key7'), true);
          expect(result[1].contains('key8'), true);
        }));

      });

      setUp(() {});

      test('with pattern parameter', () {

        handler1.scan(0, pattern: '*3')
        .then(expectAsync((result) {
          expect(result, ['0',
          [
              'key3'
          ]
          ]);
        }));

      });

      test('with count parameter', () {

        handler1.scan(0, count: 2)
        .then(expectAsync((result) {
          expect(result.length, 2);
        }));

      });

      test('with both parameters', () {

        handler1.scan(0, pattern: 'k*', count: 2)
        .then(expectAsync((result) {
          expect(result.length, 2);
        }));

      });

    });

    group('expire', () {

      test('expire', () {

        handler1.set('testExpire', 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.expire('testExpire', 2000);
        }))
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

    });

    group('persist', () {

      test('persist', () {

        handler1.setex('testPersist', 2000, 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.persist('testPersist');
        }))
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

    });

    group('renamenx', () {

      test('renamenx', () {

        handler1.set('testRenamenx', 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.renamenx('testRenamenx', 'testRenamenxNew');
        }))
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

    });

    group('expireat', () {

      test('expireat', () {

        handler1.set('testExpireAt', 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.expireat('testExpireAt', 1493840000);
        }))
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

    });

    group('pexpire', () {

      test('pexpire', () {

        handler1.set('testPexpire', 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.pexpire('testPexpire', 2000000);
        }))
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

    });

    /*
    group('restore', () {

      test('restore', () {

        handler1.restore('testRestore', 0, "\x00\x01a\x06\x00)\x13\x87\x1bzcA'")
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });
    */

    group('keys', () {

      setUp(() {

        handler1.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('keys', () {

        handler1.set('testKeys', 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.keys('*');
        }))
        .then(expectAsync((result) {
          expect(result, ['testKeys']);
        }));

      });

      setUp(() {});

    });

    group('pexpireat', () {

      test('pexpireat', () {

        handler1.set('testPexpireAt', 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler1.pexpireat('testPexpireAt', 1493840000000);
        }))
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      group('sort', () {

        test('1 param', () {

          handler1.lpush('testSort1', ['1', '2', '2', '1', '1', '4'])
          .then(expectAsync((result) {
            expect(result, 6);
            return handler1.sort('testSort1');
          }))
          .then(expectAsync((result) {
            expect(result, ['1', '1', '1', '2', '2', '4']);
          }));

        });

        test('all params', () {

          handler1.lpush('testSort2', ['a1', 'a2', 'b2', 'b1', 'c1', 'c4'])
          .then(expectAsync((result) {
            expect(result, 6);
            return handler1.sort('testSort1',
              byPattern: 'weight_*',
              offset: 0,
              count: 10,
              getPattern: ['object_*'],
              order: 'desc',
              alpha: true,
              destinationKey: 'testSort2'
            );
          }))
          .then(expectAsync((result) {
            expect(result, 6);
          }));

        });

      });

    });

  });

}
