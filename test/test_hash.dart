part of lib_test;

testHash(IRedis handler) {

  group('Hash',() {

    group('hset', () {

      setUp(() {
        handler.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('non-exist field', () {

        handler.hset('testHset', 'field1', 'value1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      setUp(() {});

      test('exist field', () {

        handler.hset('testHset', 'field1', 'value2')
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

    });

    group('hdel', () {

      setUp(() {

        handler.hmset('testHdel', {'field1': 'value1', 'field2': 'value2', 'field3': 'value3'})
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('non-exist field', () {

        handler.hdel('testHdel', 'field4')
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

      setUp(() {});

      test('exist field', () {

        handler.hdel('testHdel', 'field1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      test('multiple field', () {

        handler.hdel('testHdel', ['field2', 'field3', 'field5'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

    });

    group('hincrby', () {

      test('non-exist field', () {

        handler.hincrby('testHincrby', 'field1', 2)
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

      test('exist field', () {

        handler.hincrby('testHincrby', 'field1', 5)
        .then(expectAsync((result) {
          expect(result, 7);
        }));

      });

    });

    group('hmget', () {

      setUp(() {

        handler.hmset('testHmget', {'field1': 'value1', 'field2': 'value2', 'field3': 'value3'})
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('hmget', () {

        handler.hmget('testHmget', ['field1', 'field4'])
        .then(expectAsync((result) {
          expect(result, ['value1', null]);
        }));

      });

      setUp(() {});

    });

    group('hvals', () {

      setUp(() {

        handler.hmset('testHvals', {'field1': 'value1', 'field2': 'value2', 'field3': 'value3'})
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('hvals', () {

        handler.hvals('testHvals')
        .then(expectAsync((result) {
          expect(result, ['value1', 'value2', 'value3']);
        }));

      });

      setUp(() {});

    });

    group('hexists', () {

      setUp(() {

        handler.hmset('testHexists', {'field1': 'value1', 'field2': 'value2', 'field3': 'value3'})
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('hexists', () {

        handler.hexists('testHexists', 'field1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      setUp(() {});

    });

    group('hincrbyfloat', () {

      test('non-exist field', () {

        handler.hincrbyfloat('testHincrbyfloat', 'field1', .2)
        .then(expectAsync((result) {
          expect(result, '0.2');
        }));

      });

      test('exist field', () {

        handler.hincrbyfloat('testHincrbyfloat', 'field1', .5)
        .then(expectAsync((result) {
          expect(result, '0.7');
        }));

      });

    });

    group('hmset', () {

      test('hmset', () {
        handler.hmset('testHmset', {'field1': 'value1', 'field2': 'value2', 'field3': 'value3'})
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('hscan', () {

      setUp(() {

        handler.hmset('testHscan',
            {
              'field1': 'value1',
              'field2': 'value2',
              'field3': 'value3',
              'field4': 'value4',
              'field5': 'value5',
              'field6': 'value6',
              'field7': 'value7',
              'field8': 'value8',
            }
        )
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('2 parameters', () {

        handler.hscan('testHscan', 0)
        .then(expectAsync((result) {
          expect(result, ['0',
            [
                'field1', 'value1',
                'field2', 'value2',
                'field3', 'value3',
                'field4', 'value4',
                'field5', 'value5',
                'field6', 'value6',
                'field7', 'value7',
                'field8', 'value8',
            ]
          ]);
        }));

      });

      setUp(() {});

      test('with pattern parameter', () {

        handler.hscan('testHscan', 0, pattern: '*3')
        .then(expectAsync((result) {
          expect(result, ['0',
            [
                'field3', 'value3',
            ]
          ]);
        }));

      });

      test('with count parameter', () {

        handler.hscan('testHscan', 0, count: 2)
        .then(expectAsync((result) {
          // redis bug here
          expect(result, ['0',
            [
              'field1', 'value1',
              'field2', 'value2',
              'field3', 'value3',
              'field4', 'value4',
              'field5', 'value5',
              'field6', 'value6',
              'field7', 'value7',
              'field8', 'value8',
            ]
          ]);
        }));

      });

      test('with both parameters', () {

        handler.hscan('testHscan', 0, pattern: 'f*', count: 2)
        .then(expectAsync((result) {
          // redis bug here
          expect(result, ['0',
            [
              'field1', 'value1',
              'field2', 'value2',
              'field3', 'value3',
              'field4', 'value4',
              'field5', 'value5',
              'field6', 'value6',
              'field7', 'value7',
              'field8', 'value8',
            ]
          ]);
        }));

      });

    });

    group('hget', () {

      setUp(() {

        handler.hmset('testHget',
          {
            'field1': 'value1',
            'field2': 'value2',
            'field3': 'value3',
            'field4': 'value4',
            'field5': 'value5',
            'field6': 'value6',
            'field7': 'value7',
            'field8': 'value8',
          }
        )
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('hget', () {

        handler.hget('testHget', 'field1')
        .then(expectAsync((result) {
          expect(result, 'value1');
        }));

      });

      setUp(() {});

    });

    group('hkeys', () {

      setUp(() {

        handler.hmset('testHkeys',
          {
            'field1': 'value1',
            'field2': 'value2',
            'field3': 'value3',
            'field4': 'value4',
            'field5': 'value5',
            'field6': 'value6',
            'field7': 'value7',
            'field8': 'value8',
          }
        )
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('hkeys', () {

        handler.hkeys('testHkeys')
        .then(expectAsync((result) {
          expect(result, ['field1', 'field2', 'field3', 'field4', 'field5', 'field6', 'field7', 'field8']);
        }));

      });

      setUp(() {});

    });

    group('hgetall', () {

      setUp(() {

        handler.hmset('testHgetall',
          {
            'field1': 'value1',
            'field2': 'value2',
            'field3': 'value3',
          }
        )
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('hgetall', () {

        handler.hgetall('testHgetall')
        .then(expectAsync((result) {
          expect(result, ['field1', 'value1', 'field2', 'value2', 'field3', 'value3']);
        }));

      });

      setUp(() {});

    });

    group('hlen', () {

      setUp(() {

        handler.hmset('testHlen',
          {
            'field1': 'value1',
            'field2': 'value2',
            'field3': 'value3',
          }
        )
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('hlen', () {

        handler.hlen('testHlen')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

    });


    group('hsetnx', () {

      test('non-exist field', () {

        handler.hsetnx('testHsetnx', 'field1', 'value1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      test('exist field', () {

        handler.hsetnx('testHsetnx', 'field1', 'value1')
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

    });

  });

}

