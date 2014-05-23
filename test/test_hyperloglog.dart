part of lib_test;

testHyperLogLog(IRedis handler) {

  group('HyperLogLog',() {

    group('pfadd', () {

      setUp(() {
        handler.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('single value', () {

        handler.pfadd('testPfadd', 'value1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      setUp(() {});

      test('multiple values', () {

        handler.pfadd('testPfadd', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

    });

    group('pfcount', () {

      setUp(() {

        handler.pfadd('testPfcount1', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 1);
        }));

        handler.pfadd('testPfcount2', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      test('single key', () {

        handler.pfcount('testPfcount1')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

      test('multiple keys', () {

        handler.pfcount(['testPfcount1', 'testPfcount2'])
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

    });

    group('pfmerge', () {

      setUp(() {

        handler.pfadd('testPfmerge1', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 1);
        }));

        handler.pfadd('testPfmerge2', ['value1', 'value2', 'value3'])
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      test('single key', () {

        handler.pfmerge('testPfmergeNew1', 'testPfmerge1')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      setUp(() {});

      test('multiple keys', () {

        handler.pfmerge('testPfmergeNew2', ['testPfmergeNew1', 'testPfmergeNew2'])
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

  });

}
