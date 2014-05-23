part of lib_test;

testList(IRedis handler) {

  group('List',() {

    group('rpush', () {

      setUp(() {
        handler.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('non-exist key', () {

        handler.rpush('testRpush', 'value1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      setUp(() {});

      test('exist key', () {

        handler.rpush('testRpush', 'value2')
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

      test('multiple values', () {

        handler.rpush('testRpush', ['value3', 'value4'])
        .then(expectAsync((result) {
          expect(result, 4);
        }));

      });

    });

    group('blpop', () {

      setUp(() {
        handler.rpush('testBlpop1', ['value1', 'value2'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));

        handler.rpush('testBlpop2', ['value1', 'value2'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));
      });


      test('single key', () {

        handler.blpop('testBlpop1', 0)
        .then(expectAsync((result) {
          expect(result, ['testBlpop1', 'value1']);
        }));

      });

      setUp(() {});

      test('multiple key', () {

        handler.blpop(['testBlpop1', 'testBlpop2'], 0)
        .then(expectAsync((result) {
          expect(result, ['testBlpop1', 'value2']);
        }));

      });

    });

    group('llen', () {

      setUp(() {

        handler.rpush('testLlen', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });


      test('llen', () {

        handler.llen('testLlen')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

    });

    group('lrem', () {

      setUp(() {

        handler.rpush('testLrem', ['value1', 'value1', 'value2', 'value2', 'value3', 'value3'])
        .then(expectAsync((result) {
          expect(result, 6);
        }));

      });


      test('from head', () {

        handler.lrem('testLrem', 1, 'value3')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      setUp(() {});

      test('from tail', () {

        handler.lrem('testLrem', -1, 'value3')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      test('all', () {

        handler.lrem('testLrem', 0, 'value2')
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

    });

    group('brpop', () {

      setUp(() {
        handler.rpush('testBrpop1', ['value1', 'value2'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));

        handler.rpush('testBrpop2', ['value1', 'value2'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));
      });


      test('single key', () {

        handler.brpop('testBrpop1', 0)
        .then(expectAsync((result) {
          expect(result, ['testBrpop1', 'value2']);
        }));

      });

      setUp(() {});

      test('multiple key', () {

        handler.brpop(['testBrpop1', 'testBrpop2'], 0)
        .then(expectAsync((result) {
          expect(result, ['testBrpop1', 'value1']);
        }));

      });

    });

    group('lpop', () {

      setUp(() {

        handler.rpush('testLpop', ['value1', 'value2'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });


      test('lpop', () {

        handler.lpop('testLpop')
        .then(expectAsync((result) {
          expect(result, 'value1');
        }));

      });

      setUp(() {});

    });

    group('lset', () {

      setUp(() {

        handler.rpush('testLset', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });


      test('from head', () {

        handler.lset('testLset', 1, 'VALUE2')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      setUp(() {});

      test('from tail', () {

        handler.lset('testLset', -1, 'VALUE3')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('rpushx', () {

      setUp(() {

        handler.rpush('testRpushx', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });


      test('non-exist key', () {

        handler.rpushx('non-testRpushx', 'value4')
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

      setUp(() {});

      test('exist key', () {

        handler.rpushx('testRpushx', 'value4')
        .then(expectAsync((result) {
          expect(result, 4);
        }));

      });

    });

    group('rpoplpush', () {

      setUp(() {

        handler.rpush('testRpoplpush', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });


      test('rpoplpush', () {

        handler.rpoplpush('testRpoplpush', 'testRpoplpush-another')
        .then(expectAsync((result) {
          expect(result, 'value3');
        }));

      });

      setUp(() {});

    });

    group('brpoplpush', () {

      setUp(() {
        handler.rpush('testBrpoplpush1', ['value1', 'value2'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));

        handler.rpush('testBrpoplpush2', ['value1', 'value2'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));
      });


      test('brpoplpush', () {

        handler.brpoplpush('testBrpoplpush1', 'testBrpoplpush2', 0)
        .then(expectAsync((result) {
          expect(result, 'value2');
        }));

      });

      setUp(() {});

    });

    group('lpush', () {

      test('non-exist key', () {

        handler.lpush('testLpush', 'value1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      test('exist key', () {

        handler.lpush('testLpush', 'value2')
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

      test('multiple values', () {

        handler.lpush('testLpush', ['value3', 'value4'])
        .then(expectAsync((result) {
          expect(result, 4);
        }));

      });

    });

    group('ltrim', () {

      setUp(() {

        handler.rpush('testLtrim', ['value1', 'value2', 'value3', 'value4'])
        .then(expectAsync((result) {
          expect(result, 4);
        }));

      });

      test('ltrim', () {

        handler.ltrim('testLtrim', 1, 3)
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      setUp(() {});

    });

    group('lindex', () {

      setUp(() {

        handler.rpush('testLindex', ['value1', 'value2', 'value3', 'value4'])
        .then(expectAsync((result) {
          expect(result, 4);
        }));

      });

      test('lindex', () {

        handler.lindex('testLindex', 2)
        .then(expectAsync((result) {
          expect(result, 'value3');
        }));

      });

      setUp(() {});

    });

    group('lpushx', () {

      setUp(() {

        handler.rpush('testLpushx', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });


      test('non-exist key', () {

        handler.rpushx('non-testLpushx', 'value4')
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

      setUp(() {});

      test('exist key', () {

        handler.rpushx('testLpushx', 'value4')
        .then(expectAsync((result) {
          expect(result, 4);
        }));

      });

    });

    group('rpop', () {

      setUp(() {

        handler.rpush('testRpop', ['value1', 'value2'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });


      test('lpop', () {

        handler.rpop('testRpop')
        .then(expectAsync((result) {
          expect(result, 'value2');
        }));

      });

      setUp(() {});

    });

    group('linsert', () {

      setUp(() {

        handler.rpush('testLinsert', ['value1', 'value2'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });


      test('linsert', () {

        handler.linsert('testLinsert', 'before', 'value1', 'value0')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

    });

    group('lrange', () {

      setUp(() {

        handler.rpush('testLrange', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });


      test('lrange', () {

        handler.lrange('testLrange', 0, -1)
        .then(expectAsync((result) {
          expect(result, ['value1', 'value2', 'value3']);
        }));

      });

      setUp(() {});

    });

  });

}
