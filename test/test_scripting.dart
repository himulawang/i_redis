part of lib_test;

testScripting(IRedis handler) {

  group('Scripting',() {

    group('eval', () {

      setUp(() {
        handler.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('no args', () {

        handler.set('testEval', 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          return handler.eval("return redis.call('get','testEval')");
        }))
        .then(expectAsync((result) {
          expect(result, 'value');
        }));

      });

      setUp(() {});

      test('args', () {

        handler.eval("return {KEYS[1],KEYS[2],ARGV[1],ARGV[2]}",
                    { 'key1': 'first', 'key2': 'second' })
        .then(expectAsync((result) {
          expect(result, ['key1', 'key2', 'first', 'second']);
        }));

      });

    });

    group('evalsha', () {

      test('no args', () {

        handler.set('testEval', 'value')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          // echo -n "return redis.call('get','testEval')" | sha1sum
          return handler.evalsha("c8837edef9a9cf35cfbf3a666b6b98c8c73f2ce8");
        }))
        .then(expectAsync((result) {
          expect(result, 'value');
        }));

      });

      test('args', () {

        // echo -n "return {KEYS[1],KEYS[2],ARGV[1],ARGV[2]}" | sha1sum
        handler.evalsha("a42059b356c875f0717db19a51f6aaca9ae659ea",
                    { 'key1': 'first', 'key2': 'second' })
        .then(expectAsync((result) {
          expect(result, ['key1', 'key2', 'first', 'second']);
        }));

      });

    });

    group('script exists', () {

      test('single script', () {

        handler.scriptExists('c8837edef9a9cf35cfbf3a666b6b98c8c73f2ce8')
        .then(expectAsync((result) {
          expect(result, [1]);
        }));

      });

      test('multiple scripts', () {

        handler.scriptExists(['c8837edef9a9cf35cfbf3a666b6b98c8c73f2ce8',
                             'a42059b356c875f0717db19a51f6aaca9ae659ea',
                             'aaa'])
        .then(expectAsync((result) {
          expect(result, [1, 1, 0]);
        }));

      });

    });

    group('script kill', () {

      test('script kill', () {

        handler.scriptKill()
        .then((result) {})
        .catchError(expectAsync((e) {
          expect(e, 'NOTBUSY No scripts in execution right now.');
        }));
        ;

      });

    });

    group('script flush', () {

      test('script flush', () {

        handler.scriptFlush()
        .then((result) {
          expect(result, IRedis.OK);
        });

      });

    });

    group('script load', () {

      test('script load', () {

        handler.scriptLoad("return redis.call('get','testEval')")
        .then((result) {
          expect(result, 'c8837edef9a9cf35cfbf3a666b6b98c8c73f2ce8');
        });

      });

    });

  });

}
