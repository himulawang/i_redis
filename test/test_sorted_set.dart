part of lib_test;

testSortedSet(IRedis handler) {

  group('Sorted Set',() {

    group('zadd', () {

      setUp(() {
        handler.flushdb().then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));
      });

      test('zadd', () {

        handler.zadd('testZadd', {'key1': 8, 'key2': 6, 'key3': 12})
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

    });

    group('zlexcount', () {

      setUp(() {

        handler.zadd('testZlexcount', {'key1': 0, 'key2': 0, 'key3': 0})
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('zlexcount', () {

        handler.zlexcount('testZlexcount', '[key1', '[key3')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

    });

    group('zrem', () {

      setUp(() {

        handler.zadd('testZrem', {'key1': 1, 'key2': 3, 'key3': 7})
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      test('single value', () {

        handler.zrem('testZrem', 'key1')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      setUp(() {});

      test('multiple value', () {

        handler.zrem('testZrem', ['key2', 'key3'])
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

    });

    group('zrevrangebyscore', () {

      setUp(() {

        handler.zadd('testZrevrangebyscore', {'key1': 1, 'key2': 3, 'key3': 7,
                                            'key4': 10, 'key5': 13 })
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('withscores', () {

        handler.zrevrangebyscore('testZrevrangebyscore', '(13', '7', withScores: true)
        .then(expectAsync((result) {
          expect(result, ['key4', '10', 'key3', '7']);
        }));

      });

      setUp(() {});

      test('with limit and count', () {

        handler.zrevrangebyscore('testZrevrangebyscore', '13', '1',
                                offset: 1, count: 3)
        .then(expectAsync((result) {
          expect(result, ['key4', 'key3', 'key2']);
        }));

      });

    });

    group('zcard', () {

      setUp(() {

        handler.zadd('testZcard', {'key1': 1, 'key2': 3, 'key3': 7,
            'key4': 10, 'key5': 13 })
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('zcard', () {

        handler.zcard('testZcard')
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      setUp(() {});

    });

    group('zrange', () {

      setUp(() {

        handler.zadd('testZrange', {'key1': 1, 'key2': 3, 'key3': 7,
            'key4': 10, 'key5': 13 })
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('without scores', () {

        handler.zrange('testZrange', 1, 7)
        .then(expectAsync((result) {
          expect(result, ['key2', 'key3', 'key4', 'key5']);
        }));

      });

      setUp(() {});

      test('withscores', () {

        handler.zrange('testZrange', 1, 7, withScores: true)
        .then(expectAsync((result) {
          expect(result, ['key2', '3', 'key3', '7', 'key4', '10', 'key5', '13']);
        }));

      });

    });

    group('zremrangebylex', () {

      setUp(() {

        handler.zadd('testZremrangebylex', {'key1': 0, 'key2': 0, 'key3': 0,
            'key4': 0, 'key5': 0 })
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('zremrangebylex', () {

        handler.zremrangebylex('testZremrangebylex', '[key1', '[key3')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

    });

    group('zrevrank', () {

      setUp(() {

        handler.zadd('testZrevrank', {'key1': 2, 'key2': 6, 'key3': 7,
            'key4': 8, 'key5': 10})
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('zrevrank', () {

        handler.zrevrank('testZrevrank', 'key2')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

    });

    group('zcount', () {

      setUp(() {

        handler.zadd('testZcount', {'key1': 2, 'key2': 6, 'key3': 7,
            'key4': 8, 'key5': 10})
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('zcount', () {

        handler.zcount('testZcount', '6', '8')
        .then(expectAsync((result) {
          expect(result, 3);
        }));

      });

      setUp(() {});

    });

    group('zrangebylex', () {

      setUp(() {

        handler.zadd('testZrangebylex', {'key1': 0, 'key2': 0, 'key3': 0,
            'key4': 0, 'key5': 0 })
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('without limit and count', () {

        handler.zrangebylex('testZrangebylex', '[key1', '[key4')
        .then(expectAsync((result) {
          expect(result, ['key1', 'key2', 'key3', 'key4']);
        }));

      });

      setUp(() {});

      test('with limit and count', () {

        handler.zrangebylex('testZrangebylex', '[key1', '[key5', offset: 1, count: 2)
        .then(expectAsync((result) {
          expect(result, ['key2', 'key3']);
        }));

      });

    });

    group('zremrangebyrank', () {

      setUp(() {

        handler.zadd('testZremrangebyrank', {'key1': 2, 'key2': 6, 'key3': 7,
            'key4': 8, 'key5': 10})
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('zremrangebyrank', () {

        handler.zremrangebyrank('testZremrangebyrank', 0, 1)
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

      setUp(() {});

    });

    group('zscore', () {

      setUp(() {

        handler.zadd('testZscore', {'key1': 2, 'key2': 6, 'key3': 7,
            'key4': 8, 'key5': 10})
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('zscore', () {

        handler.zscore('testZscore', 'key2')
        .then(expectAsync((result) {
          expect(result, '6');
        }));

      });

      setUp(() {});

    });

    group('zincrby', () {

      setUp(() {

        handler.zadd('testZincrby', {'key1': 2, 'key2': 6, 'key3': 7,
            'key4': 8, 'key5': 10})
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('zincrby', () {

        handler.zincrby('testZincrby', 7, 'key2')
        .then(expectAsync((result) {
          expect(result, '13');
        }));

      });

      setUp(() {});

    });

    group('zrangebyscore', () {

      setUp(() {

        handler.zadd('testZrangebyscore', {'key1': 1, 'key2': 3, 'key3': 7,
            'key4': 10, 'key5': 13 })
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('withscores', () {

        handler.zrangebyscore('testZrangebyscore', '7', '(13', withScores: true)
        .then(expectAsync((result) {
          expect(result, ['key3', '7', 'key4', '10']);
        }));

      });

      setUp(() {});

      test('with limit and count', () {

        handler.zrangebyscore('testZrangebyscore', '1', '13',
        offset: 1, count: 3)
        .then(expectAsync((result) {
          expect(result, ['key2', 'key3', 'key4']);
        }));

      });

    });

    group('zremrangebyscore', () {

      setUp(() {

        handler.zadd('testZremrangebyscore', {'key1': 2, 'key2': 6, 'key3': 7,
            'key4': 8, 'key5': 10})
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('zremrangebyscore', () {

        handler.zremrangebyscore('testZremrangebyscore', 2, 6)
        .then(expectAsync((result) {
          expect(result, 2);
        }));

      });

      setUp(() {});

    });

    group('zunionstore', () {

      setUp(() {

        handler.zadd('testZunionstore1', {'key1': 2, 'key2': 6, 'key3': 7,
            'key4': 8, 'key5': 10})
        .then(expectAsync((result) {
          expect(result, 5);
        }));

        handler.zadd('testZunionstore2', {'key1': 2, 'key2': 6, 'key3': 7,
            'key4': 8, 'key5': 10})
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('weight and keys length are not same', () {

        expect(() {
          handler.zunionstore(
              'testZunionstoreNew',
              ['testZunionstore1', 'testZunionstore2'],
              weights: [1, 3, 5]
          );
        }, throwsA(predicate((e) => e is IRedisException)));

      });

      setUp(() {});

      test('invalid aggregate', () {

        expect(() {
          handler.zunionstore(
              'testZunionstoreNew',
              ['testZunionstore1', 'testZunionstore2'],
              aggregate: 'invalidParam'
          );
        }, throwsA(predicate((e) => e is IRedisException)));

      });

      test('no special parameter', () {

        handler.zunionstore(
            'testZunionstoreNew1',
            ['testZunionstore1', 'testZunionstore2']
        )
        .then((result) {
          expect(result, 5);
        });

      });

      test('with weights', () {

        handler.zunionstore(
            'testZunionstoreNew2',
            ['testZunionstore1', 'testZunionstore2'],
            weights: [2, 3]
        )
        .then((result) {
          expect(result, 5);
        });

      });

      test('with aggregate', () {

        handler.zunionstore(
            'testZunionstoreNew3',
            ['testZunionstore1', 'testZunionstore2'],
            aggregate: IRedisCommand.AGGREGATE_MIN
        )
        .then((result) {
          expect(result, 5);
        });

      });

      test('with both weights and aggregate', () {

        handler.zunionstore(
            'testZunionstoreNew3',
            ['testZunionstore1', 'testZunionstore2'],
            weights: [2, 3],
            aggregate: IRedisCommand.AGGREGATE_SUM
        )
        .then((result) {
          expect(result, 5);
        });

      });

    });

    group('zinterstore', () {

      setUp(() {

        handler.zadd('testZinterstore1', {'key1': 2, 'key2': 6, 'key3': 7,
            'key4': 8, 'key5': 10})
        .then(expectAsync((result) {
          expect(result, 5);
        }));

        handler.zadd('testZinterstore2', {'key1': 2, 'key2': 6, 'key3': 7,
            'key4': 8, 'key5': 10})
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('weight and keys length are not same', () {

        expect(() {
          handler.zinterstore(
              'testZinterstoreNew',
              ['testZinterstore1', 'testZinterstore2'],
              weights: [1, 3, 5]
          );
        }, throwsA(predicate((e) => e is IRedisException)));

      });

      setUp(() {});

      test('invalid aggregate', () {

        expect(() {
          handler.zinterstore(
              'testZinterstoreNew',
              ['testZinterstore1', 'testZinterstore2'],
              aggregate: 'invalidParam'
          );
        }, throwsA(predicate((e) => e is IRedisException)));

      });

      test('no special parameter', () {

        handler.zinterstore(
            'testZinterstoreNew1',
            ['testZinterstore1', 'testZinterstore2']
        )
        .then((result) {
          expect(result, 5);
        });

      });

      test('with weights', () {

        handler.zinterstore(
            'testZinterstoreNew2',
            ['testZinterstore1', 'testZinterstore2'],
            weights: [2, 3]
        )
        .then((result) {
          expect(result, 5);
        });

      });

      test('with aggregate', () {

        handler.zinterstore(
            'testZinterstoreNew3',
            ['testZinterstore1', 'testZinterstore2'],
            aggregate: IRedisCommand.AGGREGATE_MIN
        )
        .then((result) {
          expect(result, 5);
        });

      });

      test('with both weights and aggregate', () {

        handler.zinterstore(
            'testZinterstoreNew3',
            ['testZinterstore1', 'testZinterstore2'],
            weights: [2, 3],
            aggregate: IRedisCommand.AGGREGATE_SUM
        )
        .then((result) {
          expect(result, 5);
        });

      });

    });

    group('zrank', () {

      setUp(() {

        handler.zadd('testZrank', {'key1': 2, 'key2': 6, 'key3': 7,
            'key4': 8, 'key5': 10})
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('zrank', () {

        handler.zrank('testZrank', 'key2')
        .then(expectAsync((result) {
          expect(result, 1);
        }));

      });

      setUp(() {});

    });

    group('zrevrange', () {

      setUp(() {

        handler.zadd('testZrevrange', {'key1': 1, 'key2': 3, 'key3': 7,
            'key4': 10, 'key5': 13 })
        .then(expectAsync((result) {
          expect(result, 5);
        }));

      });

      test('without scores', () {

        handler.zrevrange('testZrevrange', 1, 7)
        .then(expectAsync((result) {
          expect(result, ['key4', 'key3', 'key2', 'key1']);
        }));

      });

      setUp(() {});

      test('withscores', () {

        handler.zrevrange('testZrevrange', 1, 7, withScores: true)
        .then(expectAsync((result) {
          expect(result, ['key4', '10', 'key3', '7', 'key2', '3', 'key1', '1']);
        }));

      });

    });

    group('zscan', () {

      setUp(() {

        handler.zadd('testZscan', {'key1': 1, 'key2': 3, 'key3': 7,
            'key4': 10, 'key5': 13, 'key6': 15, 'key7': 17 })
        .then(expectAsync((result) {
          expect(result, 7);
        }));

      });

      test('zscan', () {

        handler.zscan('testZscan', 0, pattern: 'key*', count: 3)
        .then(expectAsync((result) {
          expect(result[0], '0');
          expect(result[1].length, 14);
        }));

      });

      setUp(() {});

    });

  });

}
