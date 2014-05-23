part of lib_test;

testSpecial(IRedis handler) {

  group('special',() {

    group('multi-bigdata', () {

      setUp(() {
        handler.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('multiple hmget', () {

        List waitList = [];

        StringBuffer bigSB = new StringBuffer();
        for (num i = 0; i < 60000; ++i) {
          bigSB.write('a');
        }
        String bigString = bigSB.toString();

        for (num i = 0; i < 10; ++i) {
          waitList.add(
              handler.hmset('testMulti-bigdata${i}', {
                  'field1': bigString,
                  'field2': bigString,
                  'field3': bigString,
                  'field4': bigString,
              })
          );
        }

        Future.wait(waitList)
        .then(expectAsync((results) {
          print(results);
        }));

      });

      setUp(() {});

    });

  });

}
