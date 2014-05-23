part of lib_test;

testServer(IRedis handler1, IRedis handler2) {

  group('Server',() {

    group('bgsave', () {

      test('bgsave', () {

        handler1.bgsave()
        .then(expectAsync((result) {
          expect(result, 'Background saving started');
        }));

      });

    });

    group('bgrewriteaof', () {

      test('bgrewriteaof', () {

        handler1.bgrewriteaof()
        .then(expectAsync((result) {
          expect(result, 'Background append only file rewriting scheduled');
        }));

      });

    });

    group('config get', () {

      test('config get', () {

        handler1.configGet('*max-*-entries*')
        .then(expectAsync((result) {
          expect(result[0], 'hash-max-ziplist-entries');
          expect(result[2], 'list-max-ziplist-entries');
          expect(result[4], 'set-max-intset-entries');
          expect(result[6], 'zset-max-ziplist-entries');
        }));

      });

    });

    group('flushall', () {

      test('flushall', () {

        handler1.flushall()
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('slaveof', () {

      test('slaveof', () {

        handler1.slaveof('127.0.0.1', 6380)
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('slaveof no one', () {

        handler1.slaveofNoOne()
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('config rewrite', () {

      test('config rewrite', () {

        handler1.configRewrite()
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('flushdb', () {

      test('flushdb', () {

        handler1.flushdb()
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('slowlog', () {

      test('len', () {

        handler1.slowlog('len')
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

      test('reset', () {

        handler1.slowlog('reset')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

      test('get', () {

        handler1.slowlog('get', 2)
        .then(expectAsync((result) {
          expect(result, []);
        }));

      });

      test('invalid param', () {

        expect(
            () {
              handler1.slowlog('param')
              .then(expectAsync((result) {
                expect(result, []);
              }));
            },
            throwsA(predicate((e) => e is IRedisException))
        );

      });

    });

    group('client kill', () {

      test('client kill', () {

        handler1.clientKill('127.0.0.1:333333')
        .catchError(expectAsync((e) => e.toString() == 'Caught ERR No such client'));

      });

    });

    group('config set', () {

      test('config set', () {

        handler1.configSet('maxclients', '10000')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('info', () {

      test('info', () {

        handler1.info()
        .then(expectAsync((result) {
          expect(result.split('\r\n') is List, true);
        }));

      });

    });

    group('client list', () {

      test('client list', () {

        handler1.clientList()
        .then(expectAsync((result) {
          expect(result.split(',') is List, true);
        }));

      });

    });

    group('config resetstat', () {

      test('config resetstat', () {

        handler1.configResetstat()
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('lastsave', () {

      test('lastsave', () {

        handler1.lastsave()
        .then(expectAsync((result) {
          expect(result is num, true);
        }));

      });

    });

    group('time', () {

      test('time', () {

        handler1.time()
        .then(expectAsync((result) {
          expect(result is List, true);
        }));

      });

    });

    group('client getname', () {

      test('client getname', () {

        handler1.clientGetname()
        .then(expectAsync((result) {
          expect(result, null);
        }));

      });

    });

    group('dbsize', () {

      test('dbsize', () {

        handler1.dbsize()
        .then(expectAsync((result) {
          expect(result, 0);
        }));

      });

    });

    /*
    group('client pause', () {

      test('client pause', () {

        handler.clientPause(1)
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });
    */

    group('debug object', () {

      test('debug object', () {

        handler1.set('testDebugObject', 'value')
        .then((result) {
          return handler1.debugObject('testDebugObject');
        })
        .then(expectAsync((result) {
          expect(result.startsWith('Value'), true);
        }));

      });

    });

    group('save', () {

      test('save', () {

        handler1.save()
        .catchError(expectAsync((e) {
          expect(e, 'ERR Background save already in progress');
        }));

      });

    });

    group('client setname', () {

      test('client setname', () {

        handler1.clientSetname('DartClient')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    /*
    group('debug segfault', () {

      test('debug segfault', () {

        handler.debugSegfault()
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('shutdown', () {

      test('shutdown', () {

        handler.shutdown('save')
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

    group('sync', () {

      test('sync', () {

        handler.sync()
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });
    */

    group('monitor', () {

      test('monitor', () {

        handler1.monitor(expectAsync((result) {
          expect(result.contains('monitorTest'), true);
        }))
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
          handler2.set('monitorTest', 'value');
        }));

      });

    });

  });

}
