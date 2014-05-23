part of lib_test;

testTransaction(IRedis handler) {

  group('Transaction',() {

    group('multi / exec', () {

      setUp(() {
        handler.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('multi exec', () {

        handler.multi();
        handler.set('testMultiExec1', 'value1');
        handler.get('testMultiExec1');
        handler.set('testMultiExec2', 'value2');
        handler.get('testMultiExec2');
        handler.exec()
        .then(expectAsync((result) {
          expect(result, [IRedis.OK, 'value1', IRedis.OK, 'value2']);
        }));

      });

      setUp(() {});

    });

    group('multi / discard', () {

      test('multi discard', () {

        handler.multi();
        handler.set('testMultiDiscard1', 'value1');
        handler.get('testMultiDiscard1');
        handler.set('testMultiDiscard2', 'value2');
        handler.get('testMultiDiscard2');
        handler.discard()
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('watch', () {

      test('single key', () {

        handler.watch('testMultiExec1')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('multiple keys', () {

        handler.watch(['testMultiExec1', 'testMultiExec2'])
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('unwatch', () {

      test('unwatch', () {

        handler.unwatch()
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

  });

}
