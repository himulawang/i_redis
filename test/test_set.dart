part of lib_test;

testSet(IRedis handler) {

  group('Set',() {

    group('sadd', () {

      setUp(() {
        handler.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('single value', () {

        handler.sadd('testSadd', 'value1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      setUp(() {});

      test('multiple value', () {

        handler.sadd('testSadd', ['value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

    });

    group('sinter', () {

      setUp(() {
        handler.sadd('testSinter1', ['value1', 'value2', 'valueCommon'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

        handler.sadd('testSinter2', ['value3', 'value4', 'valueCommon'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

        handler.sadd('testSinter3', ['value5', 'value6', 'valueCommon'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('sinter', () {

        handler.sinter(['testSinter1', 'testSinter2', 'testSinter3'])
        .then(expectAsync((result) {
          expect(result, ['valueCommon']);
        }));

      });

      setUp(() {});

    });

    group('smove', () {

      setUp(() {
        handler.sadd('testSmove1', ['value1', 'value2', 'valueCommon'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

        handler.sadd('testSmove2', ['value3', 'value4', 'valueCommon'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('smove', () {

        handler.smove('testSmove1', 'testSmove2', 'value1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      setUp(() {});

    });

    group('sunion', () {

      setUp(() {
        handler.sadd('testSunion1', ['value1', 'value2', 'valueCommon'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

        handler.sadd('testSunion2', ['value3', 'value4', 'valueCommon'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('sunion', () {

        handler.sunion(['testSunion1', 'testSunion2'])
        .then(expectAsync((result) {
          expect(result.contains('value1'), true);
          expect(result.contains('value2'), true);
          expect(result.contains('value3'), true);
          expect(result.contains('value4'), true);
          expect(result.contains('valueCommon'), true);
        }));

      });

      setUp(() {});

    });

    group('scard', () {

      setUp(() {

        handler.sadd('testScard', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('scard', () {

        handler.scard('testScard')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

    });

    group('sinterstore', () {

      setUp(() {

        handler.sadd('testSinterstore1', ['value1', 'value2', 'commonValue'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

        handler.sadd('testSinterstore2', ['value3', 'value4', 'commonValue'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('single key', () {

        handler.sinterstore('testSinterstoreNew1', 'testSinterstore1')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

      test('multiple key', () {

        handler.sinterstore('testSinterstoreNew2', ['testSinterstore1', 'testSinterstore2'])
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

    });

    group('spop', () {

      setUp(() {

        handler.sadd('testSpop', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('spop', () {

        handler.spop('testSpop')
        .then(expectAsync((result) {
          expect(result.contains('value') , true);
        }));

      });

      setUp(() {});

    });

    group('sunionstore', () {

      setUp(() {

        handler.sadd('testSunionstore1', ['value1', 'value2', 'commonValue'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

        handler.sadd('testSunionstore2', ['value3', 'value4', 'commonValue'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('single key', () {

        handler.sunionstore('testSunionstoreNew1', 'testSunionstore1')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

      test('multiple key', () {

        handler.sunionstore('testSunionstoreNew2', ['testSunionstore1', 'testSunionstore2'])
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

    });

    group('sdiff', () {

      setUp(() {

        handler.sadd('testSdiff1', ['value1', 'value2', 'commonValue'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

        handler.sadd('testSdiff2', ['value3', 'value4', 'commonValue'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('single key', () {

        handler.sdiff('testSdiff1')
        .then(expectAsync((result) {
          expect(result.contains('value1'), true);
          expect(result.contains('value2'), true);
          expect(result.contains('commonValue'), true);
        }));

      });

      setUp(() {});

      test('multiple key', () {

        handler.sdiff(['testSdiff1', 'testSdiff2'])
        .then(expectAsync((result) {
          expect(result, ['value2', 'value1']);
        }));

      });

    });

    group('sismember', () {

      setUp(() {

        handler.sadd('testSismember', ['value1', 'value2', 'commonValue'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('sismember', () {

        handler.sismember('testSismember', 'value1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      setUp(() {});

    });

    group('srandmember', () {

      setUp(() {

        handler.sadd('testSrandmember', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('srandmember', () {

        handler.srandmember('testSrandmember', 2)
        .then(expectAsync((result) {
          expect(result is List, true);
        }));

      });

      setUp(() {});

    });

    group('sscan', () {

      setUp(() {

        handler.sadd('testSscan', ['value1', 'value2', 'value3', 'value4', 'value5'])
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('sscan', () {

        handler.sscan('testSscan', 0, pattern: 'value*', count: 3)
        .then(expectAsync((result) {
          expect(result.length, 2);
        }));

      });

      setUp(() {});

    });

    group('sdiffstore', () {

      setUp(() {

        handler.sadd('testSdiffstore1', ['value1', 'value2', 'commonValue'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

        handler.sadd('testSdiffstore2', ['value3', 'value4', 'commonValue'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('single key', () {

        handler.sdiffstore('testSdiffstoreNew1', 'testSdiffstore1')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

      test('multiple key', () {

        handler.sdiffstore('testSdiffstoreNew2', ['testSdiffstore1', 'testSdiffstore2'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

    });

    group('smembers', () {

      setUp(() {

        handler.sadd('testSmembers', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('smembers', () {

        handler.smembers('testSmembers')
        .then(expectAsync((result) {
          expect(result.contains('value1'), true);
          expect(result.contains('value2'), true);
          expect(result.contains('value3'), true);
        }));

      });

      setUp(() {});

    });

    group('srem', () {

      setUp(() {

        handler.sadd('testSrem1', ['value1', 'value2', 'commonValue'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

        handler.sadd('testSrem2', ['value3', 'value4', 'commonValue'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('single key', () {

        handler.srem('testSrem1', 'value1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      setUp(() {});

      test('multiple key', () {

        handler.srem('testSrem2', ['value3', 'value4'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

    });

  });

}
