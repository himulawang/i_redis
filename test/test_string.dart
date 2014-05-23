part of lib_test;

testString(IRedis handler) {

  group('String',() {

    group('append', () {

      setUp(() {
        handler.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('non-exist key', () {

        handler.append('testAppend', 'firstString')
        .then(expectAsync((result) {
          expect(result, 11);
        }));

      });

      setUp(() {});

      test('exist key', () {

        handler.append('testAppend', 'nextString')
        .then(expectAsync((result) {
          expect(result, 21);
        }));

      });

      test('Unicode', () {

        handler.append('testAppend', '测试中文')
        .then(expectAsync((result) {
          expect(result, 33);
        }));

      });

      test('get appended key value is right', () {

        handler.get('testAppend')
        .then(expectAsync((result) {
          expect(result, 'firstStringnextString测试中文');
        }));

      });

    });

    group('set', () {

      test('set', () {

        handler.set('testSet', 'value中文')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('get', () {

      test('get', () {

        handler.get('testSet')
        .then(expectAsync((result) {
          expect(result, 'value中文');
        }));

      });

    });

    group('incrbyfloat', () {

      test('non-exist key', () {

        handler.incrbyfloat('testIncrbyfloat', .1)
        .then(expectAsync((result) {
          expect(result, '0.1');
        }));

      });

      test('exist key', () {

        handler.incrbyfloat('testIncrbyfloat', .05)
        .then(expectAsync((result) {
          expect(result, '0.15');
        }));

      });

      test('get', () {

        handler.get('testIncrbyfloat')
        .then(expectAsync((result) {
          expect(result, '0.15');
        }));

      });

    });

    group('setbit', () {

      test('first allocate', () {

        handler.setbit('testSetbit', 8, 1)
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

      test('change exist bit', () {

        handler.setbit('testSetbit', 6, 1)
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

    });

    group('bitcount', () {

      test('bitcount', () {

        handler.bitcount('testSetbit', 0, 1)
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

    });

    group('getbit', () {

      test('getbit', () {

        handler.getbit('testSetbit', 6)
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

    });

    group('mset', () {

      test('mset', () {

        handler.mset({'testMset1': 'value1', 'testMset2': 'value2'})
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('mget', () {

      test('mget', () {

        handler.mget(['testMset1', 'testMset2'])
        .then(expectAsync((result) {
          expect(result, ['value1', 'value2']);
        }));

      });

    });

    group('setex', () {

      test('setex', () {

        handler.setex('testSetEx', 60, 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('bitop', () {

      setUp(() {

        handler.mset({'testBitop1': 'foobar', 'testBitop2': 'barfoo'})
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('xor', () {

        handler.bitop(IRedisCommand.OP_XOR, 'testBitopXorDestKey', ['testBitop1', 'testBitop2'])
        .then(expectAsync((result) {
          expect(result, 6);
          return handler.get('testBitopXorDestKey');
        }))
        .then(expectAsync((result) {
          expect(result.codeUnits, [4, 14, 29, 4, 14, 29]);
        }));

      });

      setUp(() {});

      test('and', () {

        handler.bitop(IRedisCommand.OP_AND, 'testBitopAndDestKey', ['testBitop1', 'testBitop2'])
        .then(expectAsync((result) {
          expect(result, 6);
          return handler.get('testBitopAndDestKey');
        }))
        .then(expectAsync((result) {
          expect(result.codeUnits, [98, 97, 98, 98, 97, 98]);
        }));

      });

      test('or', () {

        handler.bitop(IRedisCommand.OP_OR, 'testBitopOrDestKey', ['testBitop1', 'testBitop2'])
        .then(expectAsync((result) {
          expect(result, 6);
          return handler.get('testBitopOrDestKey');
        }))
        .then(expectAsync((result) {
          expect(result.codeUnits, [102, 111, 127, 102, 111, 127]);
        }));

      });

      test('not', () {

        handler.bitop(IRedisCommand.OP_NOT, 'testBitopNotDestKey', 'testBitop1')
        .then(expectAsync((result) {
          expect(result, 6);
          return handler.get('testBitopNotDestKey');
        }))
        .then(expectAsync((result) {
          expect(result.codeUnits, [153, 144, 144, 157, 158, 141]);
        }));

      });

      test('invalid input parameter', () {

        expect(
          () => handler.bitop('aa', 'testBitopNotDestKey', 'testBitop1'),
          throwsA(predicate((e) => e is IRedisException))
        );

      });

    });

    group('getrange', () {

      setUp(() {

        handler.set('testGetrange', '01234567890')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('getrange', () {

        handler.getrange('testGetrange', 1, 9)
        .then(expectAsync((result) {
          expect(result, '123456789');
        }));

      });

      setUp(() {});

    });

    group('setnx', () {

      test('non-exist key', () {

        handler.setnx('testSetnx', 'value')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      test('exist key', () {

        handler.setnx('testSetnx', 'value')
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

    });

    group('bitpos', () {

      setUp(() {

        handler.set('testBitpos', '01234567890')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('3 parameters', () {

        handler.bitpos('testBitpos', 1, 3)
        .then(expectAsync((result) {
          expect(result, 26);
        }));

      });

      setUp(() {});

      test('2 parameter', () {

        handler.bitpos('testBitpos', 0)
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

    });

    group('getset', () {

      test('non-exist key', () {

        handler.getset('testGetset', 'oldValue')
        .then(expectAsync((result) {
          expect(result, null);
        }));

      });


      test('exist key', () {

        handler.getset('testGetset', 'newValue')
        .then(expectAsync((result) {
          expect(result, 'oldValue');
        }));

      });

    });

    group('msetnx', () {

      test('non-exist key', () {

        handler.msetnx({'testMsetnx1': 'value1', 'testMsetnx2': 'value2'})
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });


      test('exist key', () {

        handler.msetnx({'testMsetnx2': 'value2', 'testMsetnx3': 'value3'})
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

    });

    group('setrange', () {

      test('setrange', () {

        handler.set('testSetrange', 'Hello World')
        .then((result) => handler.setrange('testSetrange', 6, 'Redis'))
        .then(expectAsync((result) {
          expect(result, 11);
          return handler.get('testSetrange');
        }))
        .then(expectAsync((result) {
          expect(result, 'Hello Redis');
        }));

      });

    });

    group('incr', () {

      test('non-exist key', () {

        handler.incr('testIncr')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      test('exist key', () {

        handler.incr('testIncr')
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

    });

    group('decr', () {

      test('non-exist key', () {

        handler.decr('testDecr')
        .then(expectAsync((result) {
          expect(result, -1);
        }));

      });

      test('exist key', () {

        handler.decr('testDecr')
        .then(expectAsync((result) {
          expect(result, -2);
        }));

      });

    });

    group('psetex', () {

      test('psetex', () {

        handler.psetex('testPsetex', 10000, 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('strlen', () {

      setUp(() {

        handler.set('testStrlen', '01234567890中文')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('non-exist key', () {

        handler.strlen('testStrlenNon')
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

      setUp(() {});

      test('exist key', () {

        handler.strlen('testStrlen')
        .then(expectAsync((result) {
          expect(result, 17);
        }));

      });

    });

    group('decrby', () {

      test('non-exist key', () {

        handler.decrby('testDecrby', 2)
        .then(expectAsync((result) {
          expect(result, -2);
        }));

      });

      test('exist key', () {

        handler.decrby('testDecrby', 4)
        .then(expectAsync((result) {
          expect(result, -6);
        }));

      });

    });

  });

}