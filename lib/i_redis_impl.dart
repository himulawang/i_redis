part of i_redis;

class IRedis extends IRedisCommand {

  String host, password;
  int port, db;
  RawSocket connection;

  List queue = [];

  Map<String, Completer> pubOnSubscribe = {};
  Map<String, Completer> pubOnUnsubscribe = {};
  Map<String, Function> subOnData = {};
  Map<String, Function> subOnDone = {};

  Map<String, Completer> pubOnPsubscribe = {};
  Map<String, Completer> pubOnPunsubscribe = {};
  Map<String, Function> psubOnData = {};
  Map<String, Function> psubOnDone = {};

  // handler status
  static const int STATUS_DISCONNECTED = 0;
  static const int STATUS_CONNECTED = 1;
  static const int STATUS_AUTHENTICATED = 2;
  static const int STATUS_DB_SELECTED = 3;
  static const int STATUS_CLOSING = 4;
  int status = STATUS_DISCONNECTED;

  // mode
  bool MODE_PUBSUB = false;
  bool MODE_TRANSACTION = false;
  bool MODE_MONITOR = false;

  static const String OK = 'OK';

  // Pub/Sub
  static const CMD_SUBSCRIBE = 'subscribe';
  static const CMD_UNSUBSCRIBE = 'unsubscribe';
  static const CMD_MESSAGE = 'message';
  static const CMD_PSUBSCRIBE = 'psubscribe';
  static const CMD_PUNSUBSCRIBE = 'punsubscribe';
  static const CMD_PMESSAGE = 'pmessage';

  // Transaction
  BytesBuilder _multiQueue = null;
  static const CMD_MULTI = 'multi';
  static const CMD_EXEC = 'exec';
  static const CMD_DISCARD = 'discard';

  // Monitor
  Function _monitorOnData = null;
  static const CMD_MONITOR = 'monitor';

  // Reconnect
  List<Duration> _reconnectTimeSchedule = const [
    const Duration(milliseconds: 30),
    const Duration(milliseconds: 100),
    const Duration(milliseconds: 500),
    const Duration(seconds: 3),
    const Duration(seconds: 10),
    const Duration(seconds: 30),
  ];
  num _retryTime = 0;

  final IRESPEncoder iRESPEncoder = new IRESPEncoder();
  final IRESPDecoder iRESPDecoder = new IRESPDecoder();

  IRedis({
    String this.host: '127.0.0.1',
    int this.port: 6379,
    int this.db: 0,
    String this.password: null });

  Future connect() {
    if (status != STATUS_DISCONNECTED)
      throw new IRedisException('Cannot connect now.');

    // link handler and iRESPDecoder
    iRESPDecoder.bindOnParsed(_onParsed);
    iRESPDecoder.bindOnParserError(_onParserError);

    return RawSocket.connect(host, port)
      .then(_onConnect)
      .then(_doAuth)
      .then(_selectDB)
    ;
  }

  Future close() {
    status = STATUS_CLOSING;
    return connection.close().then((_) => status = STATUS_DISCONNECTED);
  }

  Future send(List cmd) {
    if (status != STATUS_DB_SELECTED) throw new IRedisException('IRedis handler is not ready');

    return _send(cmd);
  }

  Future _send(List cmd) {
    if (MODE_TRANSACTION) {
      if (_multiQueue == null) _multiQueue = new BytesBuilder();
      _multiQueue.add(iRESPEncoder.convert(cmd));
    } else {
      connection.write(iRESPEncoder.convert(cmd));
    }

    Completer completer = new Completer();
    queue.add(completer);

    return completer.future;
  }

  void _checkStatusReady() {
    if (status != STATUS_DB_SELECTED) throw new IRedisException('IRedis handler is not ready');
  }

  _reset() {
    queue = [];

    pubOnSubscribe = {};
    pubOnUnsubscribe = {};
    subOnData = {};
    subOnDone = {};

    pubOnPsubscribe = {};
    pubOnPunsubscribe = {};
    psubOnData = {};
    psubOnDone = {};

    bool MODE_PUBSUB = false;
    bool MODE_TRANSACTION = false;
    bool MODE_MONITOR = false;

    BytesBuilder _multiQueue = null;

    Function _monitorOnData = null;

    iRESPDecoder.reset();
  }

  _onConnect(socket) {
    connection = socket;
    connection.listen(_onData, onError: (e) {
      String message = e.toString();
      ILog.severe(message);
      if (message.contains('Broken pipe')) {
        _reset();
        status = STATUS_DISCONNECTED;
        return _reconnect();
      }

      throw e;
    }, onDone: () {
      ILog.fine('Disconnect from redis.');
      status = STATUS_DISCONNECTED;
    });
    ILog.fine('Connect successfully.');
    status = STATUS_CONNECTED;
  }

  _doAuth(_) {
    if (password == null) return status = STATUS_AUTHENTICATED;

    return auth(password)
    .then((String result) {
      if (result != OK) throw new IRedisException('Auth failed ${result}');
      ILog.fine('Auth successfully.');
      status = STATUS_AUTHENTICATED;
    }, onError: (String e) {
      if (e.contains('no password is set')) {
        ILog.warning('We supplied a password that this redis server does not require.');
        return status = STATUS_AUTHENTICATED;
      }

      throw new IRedisException('Auth error ${e}');
    });
  }

  _selectDB(_) {
    if (db == 0) {
      ILog.fine('DB is 0, do not need to select.');
      return status = STATUS_DB_SELECTED;
    }

    return _send(['select', db])
    .then((String result) {
      if (result != OK) throw new IRedisException('Select DB failed ${result}');
      ILog.fine('Select DB ${db} success.');
      status = STATUS_DB_SELECTED;
    }, onError: (String e) {
      throw new IRedisException('Select DB failed ${e}');
    });
  }

  _reconnect() {
    Duration waitFor;
    if (_retryTime > 5) {
      waitFor = _reconnectTimeSchedule[5];
    } else {
      waitFor = _reconnectTimeSchedule[_retryTime];
    }

    ++_retryTime;

    new Timer(waitFor, () {
      ILog.fine('Reconnecting, retry time: ${_retryTime}.');
      connect()
      .then((_) => _retryTime = 0)
      .catchError((e) {
        ILog.severe(e.toString());
        _reconnect();
      });
    });
  }

  _onData(RawSocketEvent event) {
    if (event == RawSocketEvent.READ) {
      iRESPDecoder.convert(connection.read());
    }
  }

  _onParsed(result) {
    // monitor data
    if (MODE_MONITOR && queue.length == 0) return _monitorOnData(result);

    // pub sub data
    if (MODE_PUBSUB &&
      result is List &&
      result.length >= 3
    ) return _onPubSubMessage(result);

    // normal data
    Completer completer = queue.removeAt(0);
    completer.complete(result);
  }

  _onParserError(String e) {
    if (MODE_PUBSUB) throw e;

    Completer completer = queue.removeAt(0);
    completer.completeError(e);
  }

  _onPubSubMessage(List result) {
    String type = result[0];
    String channel = result[1];
    String param1 = result[2].toString();

    if (type == CMD_MESSAGE &&
      subOnData.containsKey(channel))
      return subOnData[channel](param1);

    if (type == CMD_PMESSAGE &&
      psubOnData.containsKey(channel)) {
      return psubOnData[channel](param1, result[3]);
    }

    if (type == CMD_SUBSCRIBE) {
      Completer completer = pubOnSubscribe.remove(channel);
      if (completer == null) return null;
      return completer.complete(param1);
    }

    if (type == CMD_PSUBSCRIBE) {
      Completer completer = pubOnPsubscribe.remove(channel);
      if (completer == null) return null;
      return completer.complete(param1);
    }

    if (type == CMD_UNSUBSCRIBE) {
      Function onDone = subOnDone.remove(channel);
      if (onDone is Function) onDone();

      subOnData.remove(channel);

      // if there is nothing in pubOnData, switch off MODE_PUBSUB
      if (subOnData.length == 0 && psubOnData.length == 0) MODE_PUBSUB = false;

      Completer completer = pubOnUnsubscribe.remove(channel);
      if (completer == null) return null;

      return completer.complete(param1);
    }

    if (type == CMD_PUNSUBSCRIBE) {
      Function onDone = psubOnDone.remove(channel);
      if (onDone is Function) onDone();

      psubOnData.remove(channel);

      // if there is nothing in psubOnData and subOnData, switch off MODE_PUBSUB
      if (subOnData.length == 0 && psubOnData.length == 0) MODE_PUBSUB = false;

      Completer completer = pubOnPunsubscribe.remove(channel);
      if (completer == null) return null;

      return completer.complete(param1);
    }
  }

  // Pub/Sub
  Future<String> subscribe(String channel, Function onData,
                          { Function onDone: null }) {
    _checkStatusReady();
    if (queue.length != 0)
      throw new IRedisException('You cannot enter subscribe mode before all commands are completed.');

    MODE_PUBSUB = true;

    if (subOnData.containsKey(channel) &&
      subOnDone.containsKey(channel) != null) {
      subOnDone[channel]();
    }

    connection.write(iRESPEncoder.convert([CMD_SUBSCRIBE, channel]));

    Completer completer = new Completer();

    pubOnSubscribe[channel] = completer;
    subOnData[channel] = onData;
    subOnDone[channel] = onDone;

    return completer.future;
  }

  Future<String> unsubscribe(String channel) {
    _checkStatusReady();
    if (!MODE_PUBSUB)
      throw new IRedisException('You cannot unsubscribe a channel when you are not in pub/sub mode.');

    connection.write(iRESPEncoder.convert([CMD_UNSUBSCRIBE, channel]));

    Completer completer = new Completer();
    pubOnUnsubscribe[channel] = completer;

    return completer.future;
  }

  Future<String> psubscribe(String pattern, Function onData,
                           { Function onDone: null }) {
    _checkStatusReady();
    if (queue.length != 0)
      throw new IRedisException('You cannot enter subscribe mode before all commands are completed.');

    MODE_PUBSUB = true;

    if (psubOnData.containsKey(pattern) &&
      psubOnDone.containsKey(pattern) != null) {
      psubOnDone[pattern]();
    }

    connection.write(iRESPEncoder.convert([CMD_PSUBSCRIBE, pattern]));

    Completer completer = new Completer();

    pubOnPsubscribe[pattern] = completer;
    psubOnData[pattern] = onData;
    psubOnDone[pattern] = onDone;

    return completer.future;
  }

  Future<String> punsubscribe(String pattern) {
    _checkStatusReady();
    if (!MODE_PUBSUB)
      throw new IRedisException('You cannot punsubscribe a channel when you are not in pub/sub mode.');

    connection.write(iRESPEncoder.convert([CMD_PUNSUBSCRIBE, pattern]));

    Completer completer = new Completer();
    pubOnPunsubscribe[pattern] = completer;

    return completer.future;
  }

  Future multi() {
    if (MODE_TRANSACTION)
      throw new IRedisException('Transaction mode has started.');

    MODE_TRANSACTION = true;
    return send([CMD_MULTI]);
  }

  Future exec() {
    if (!MODE_TRANSACTION)
      throw new IRedisException('Transaction mode has not started.');

    Future future = send([CMD_EXEC]);

    connection.write(_multiQueue.takeBytes());

    MODE_TRANSACTION = false;
    _multiQueue = null;
    return future;
  }

  Future discard() {
    if (!MODE_TRANSACTION)
      throw new IRedisException('Transaction mode has not started.');

    Future future = send([CMD_DISCARD]);

    connection.write(_multiQueue.takeBytes());

    MODE_TRANSACTION = false;
    _multiQueue = null;
    return future;
  }

  Future monitor(Function onData) {
    _checkStatusReady();
    if (MODE_MONITOR)
      throw new IRedisException('Monitor mode has started.');
    if (queue.length != 0)
      throw new IRedisException('You cannot enter monitor mode before all commands are completed.');

    MODE_MONITOR = true;
    _monitorOnData = onData;

    return send([CMD_MONITOR]);
  }

}