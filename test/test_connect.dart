part of lib_test;

testConnect() {
  String HOST1 = '127.0.0.1';
  int PORT1 = 6379;

  String HOST2 = '127.0.0.1';
  int PORT2 = 6380;

  group('Connection', () {

    group('connect & close', () {

      test('with default value & close', () {
        IRedis handler = new IRedis();
        handler.connect()
        .then(expectAsync((_) {
          expect(handler.status, IRedis.STATUS_DB_SELECTED);
          return handler.close();
        }))
        .then(expectAsync((_)
        => expect(handler.status, IRedis.STATUS_DISCONNECTED)));
      });

      test('input host port', () {
        IRedis handler = new IRedis(host: HOST2, port: PORT2);
        handler.connect()
        .then(expectAsync((_) {
          expect(handler.status, IRedis.STATUS_DB_SELECTED);
          return handler.close();
        }))
        .then(expectAsync((_)
        => expect(handler.status, IRedis.STATUS_DISCONNECTED)));
      });

      test('doAuth with password', () {
        IRedis handler = new IRedis(host: HOST2, port: PORT2, password: '123');
        handler.connect()
        .then(expectAsync((_) {
          expect(handler.status, IRedis.STATUS_DB_SELECTED);
          return handler.close();
        }))
        .then(expectAsync((_)
        => expect(handler.status, IRedis.STATUS_DISCONNECTED)));
      });

      test('doAuth with password but redis did not set should get warning', () {
        IRedis handler = new IRedis(host: HOST2, port: PORT2, password: '123');
        handler.connect()
        .then(expectAsync((_) {
          expect(handler.status, IRedis.STATUS_DB_SELECTED);
          return handler.close();
        }))
        .then(expectAsync((_)
        => expect(handler.status, IRedis.STATUS_DISCONNECTED)));
      });

      /*
      test('doAuth with wrong password', () {
        IRedis handler = new IRedis(host: HOST2, port: PORT2, password: '223');
        handler.connect()
        .catchError(expectAsync((e) {
          expect(e.toString(), 'IRedisException: Auth error ERR invalid password');
        }));
      });
      */

      test('select db', () {
        IRedis handler = new IRedis(host: HOST1, port: PORT1, db: 2);
        handler.connect()
        .then(expectAsync((_) {
          expect(handler.status, IRedis.STATUS_DB_SELECTED);
          return handler.close();
        }))
        .then(expectAsync((_)
          => expect(handler.status, IRedis.STATUS_DISCONNECTED)));
      });

      test('select invalid db', () {
        IRedis handler = new IRedis(host: HOST1, port: PORT1, db: 220);
        handler.connect()
        .catchError(expectAsync((e) {
          expect(e.toString(), 'IRedisException: Select DB failed ERR invalid DB index');
          return handler.close();
        }))
        .then(expectAsync((_)
          => expect(handler.status, IRedis.STATUS_DISCONNECTED)));
      });

    });

    group('ping', () {

      test('ping', () {
        IRedis handler = new IRedis(host: HOST1, port: PORT1);
        handler.connect()
        .then(expectAsync((_) {
          expect(handler.status, IRedis.STATUS_DB_SELECTED);
          return handler.ping();
        }))
        .then(expectAsync((result) {
          expect(result, 'PONG');
          return handler.close();
        }));
      });

    });

    group('echo', () {

      test('echo', () {
        IRedis handler = new IRedis(host: HOST1, port: PORT1);
        handler.connect()
        .then(expectAsync((_) {
          expect(handler.status, IRedis.STATUS_DB_SELECTED);
          return handler.echo('some message');
        }))
        .then(expectAsync((result) {
          expect(result, 'some message');
          return handler.close();
        }));
      });

    });

    group('quit', () {

      test('quit', () {

        IRedis handler = new IRedis(host: HOST1, port: PORT1);
        handler.connect()
        .then(expectAsync((_) {
          expect(handler.status, IRedis.STATUS_DB_SELECTED);
          return handler.quit();
        }))
        .then(expectAsync((result) {
          expect(result, IRedis.OK);
        }));

      });

    });

  });
}
