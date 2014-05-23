part of i_redis;

class IRedisCommand {
  static const OP_AND = 'and';
  static const OP_OR = 'or';
  static const OP_XOR = 'xor';
  static const OP_NOT = 'not';

  static const AGGREGATE_SUM = 'sum';
  static const AGGREGATE_MIN = 'min';
  static const AGGREGATE_MAX = 'max';

  static const ORDER_ASC = 'asc';
  static const ORDER_DESC = 'desc';

  static const PARAM_MATCH = 'match';
  static const PARAM_COUNT = 'count';
  static const PARAM_BEFORE = 'before';
  static const PARAM_AFTER = 'after';
  static const PARAM_WITHSCORES = 'withscores';
  static const PARAM_LIMIT = 'limit';
  static const PARAM_WEIGHTS = 'weights';
  static const PARAM_AGGREGATE = 'aggregate';
  static const PARAM_CHANNELS = 'channels';
  static const PARAM_NUMSUB = 'numsub';
  static const PARAM_NUMPAT = 'numpat';
  static const PARAM_EXISTS = 'exists';
  static const PARAM_KILL = 'kill';
  static const PARAM_FLUSH = 'flush';
  static const PARAM_LOAD = 'load';
  static const PARAM_COPY = 'copy';
  static const PARAM_REPLACE = 'replace';
  static const PARAM_REFCOUNT = 'refcount';
  static const PARAM_ENCODING = 'encoding';
  static const PARAM_IDLETIME = 'idletime';
  static const PARAM_GET = 'get';
  static const PARAM_ALPHA = 'alpha';
  static const PARAM_STORE = 'store';
  static const PARAM_BY = 'by';
  static const PARAM_NO = 'no';
  static const PARAM_ONE = 'one';
  static const PARAM_REWRITE = 'rewrite';
  static const PARAM_LEN = 'len';
  static const PARAM_RESET = 'reset';
  static const PARAM_SET = 'set';
  static const PARAM_LIST = 'list';
  static const PARAM_RESETSTAT = 'resetstat';
  static const PARAM_GETNAME = 'getname';
  static const PARAM_PAUSE = 'pause';
  static const PARAM_OBJECT = 'object';
  static const PARAM_SETNAME = 'setname';
  static const PARAM_SEGFAULT = 'segfault';
  static const PARAM_SAVE = 'save';
  static const PARAM_NOSAVE = 'nosave';
  static const PARAM_ABORT = 'abort';

  // Connection
  static const CMD_AUTH = 'auth';
  static const CMD_SELECT = 'select';
  static const CMD_PING = 'ping';
  static const CMD_ECHO = 'echo';
  static const CMD_QUIT = 'quit';

  //  Key
  static const CMD_DEL = 'del';
  static const CMD_MIGRATE = 'migrate';
  static const CMD_PTTL = 'pttl';
  static const CMD_TTL = 'ttl';
  static const CMD_DUMP = 'dump';
  static const CMD_MOVE = 'move';
  static const CMD_RANDOMKEY = 'randomkey';
  static const CMD_TYPE = 'type';
  static const CMD_EXISTS = 'exists';
  static const CMD_OBJECT = 'object';
  static const CMD_RENAME = 'rename';
  static const CMD_SCAN = 'scan';
  static const CMD_EXPIRE = 'expire';
  static const CMD_PERSIST = 'persist';
  static const CMD_RENAMENX = 'renamenx';
  static const CMD_EXPIREAT = 'expireat';
  static const CMD_PEXPIRE = 'pexpire';
  static const CMD_RESTORE = 'restore';
  static const CMD_KEYS = 'keys';
  static const CMD_PEXPIREAT = 'pexpireat';
  static const CMD_SORT = 'sort';

  // String 23 commands
  static const CMD_APPEND = 'append';
  static const CMD_GET = 'get';
  static const CMD_INCRBYFLOAT = 'incrbyfloat';
  static const CMD_SETBIT = 'setbit';
  static const CMD_BITCOUNT = 'bitcount';
  static const CMD_GETBIT = 'getbit';
  static const CMD_MGET = 'mget';
  static const CMD_SETEX = 'setex';
  static const CMD_BITOP = 'bitop';
  static const CMD_GETRANGE = 'getrange';
  static const CMD_MSET = 'mset';
  static const CMD_SETNX = 'setnx';
  static const CMD_BITPOS = 'bitpos';
  static const CMD_GETSET = 'getset';
  static const CMD_MSETNX = 'msetnx';
  static const CMD_SETRANGE = 'setrange';
  static const CMD_DECR = 'decr';
  static const CMD_INCR = 'incr';
  static const CMD_PSETEX = 'psetex';
  static const CMD_STRLEN = 'strlen';
  static const CMD_DECRBY = 'decrby';
  static const CMD_INCRBY = 'incrby';
  static const CMD_SET = 'set';

  // Hash 14 commands
  static const CMD_HDEL = 'hdel';
  static const CMD_HINCRBY = 'hincrby';
  static const CMD_HMGET = 'hmget';
  static const CMD_HVALS = 'hvals';
  static const CMD_HEXISTS = 'hexists';
  static const CMD_HINCRBYFLOAT = 'hincrbyfloat';
  static const CMD_HMSET = 'hmset';
  static const CMD_HSCAN = 'hscan';
  static const CMD_HGET = 'hget';
  static const CMD_HKEYS = 'hkeys';
  static const CMD_HSET = 'hset';
  static const CMD_HGETALL = 'hgetall';
  static const CMD_HLEN = 'hlen';
  static const CMD_HSETNX = 'hsetnx';

  // List 17 commands
  static const CMD_BLPOP = 'blpop';
  static const CMD_LLEN = 'llen';
  static const CMD_LREM = 'lrem';
  static const CMD_RPUSH = 'rpush';
  static const CMD_BRPOP = 'brpop';
  static const CMD_LPOP = 'lpop';
  static const CMD_LSET = 'lset';
  static const CMD_RPUSHX = 'rpushx';
  static const CMD_BRPOPLPUSH = 'brpoplpush';
  static const CMD_LPUSH = 'lpush';
  static const CMD_LTRIM = 'ltrim';
  static const CMD_LINDEX = 'lindex';
  static const CMD_LPUSHX = 'lpushx';
  static const CMD_RPOP = 'rpop';
  static const CMD_LINSERT = 'linsert';
  static const CMD_LRANGE = 'lrange';
  static const CMD_RPOPLPUSH = 'rpoplpush';

  // Set 15 commands
  static const CMD_SADD = 'sadd';
  static const CMD_SINTER = 'sinter';
  static const CMD_SMOVE = 'smove';
  static const CMD_SUNION = 'sunion';
  static const CMD_SCARD = 'scard';
  static const CMD_SINTERSTORE = 'sinterstore';
  static const CMD_SPOP = 'spop';
  static const CMD_SUNIONSTORE = 'sunionstore';
  static const CMD_SDIFF = 'sdiff';
  static const CMD_SISMEMBER = 'sismember';
  static const CMD_SRANDMEMBER = 'srandmember';
  static const CMD_SSCAN = 'sscan';
  static const CMD_SDIFFSTORE = 'sdiffstore';
  static const CMD_SMEMBERS = 'smembers';
  static const CMD_SREM = 'srem';

  // Sorted Set 20 commands
  static const CMD_ZADD = 'zadd';
  static const CMD_ZLEXCOUNT = 'zlexcount';
  static const CMD_ZREM = 'zrem';
  static const CMD_ZREVRANGEBYSCORE = 'zrevrangebyscore';
  static const CMD_ZCARD = 'zcard';
  static const CMD_ZRANGE = 'zrange';
  static const CMD_ZREMRANGEBYLEX = 'zremrangebylex';
  static const CMD_ZREVRANK = 'zrevrank';
  static const CMD_ZCOUNT = 'zcount';
  static const CMD_ZRANGEBYLEX = 'zrangebylex';
  static const CMD_ZREMRANGEBYRANK = 'zremrangebyrank';
  static const CMD_ZSCORE = 'zscore';
  static const CMD_ZINCRBY = 'zincrby';
  static const CMD_ZRANGEBYSCORE = 'zrangebyscore';
  static const CMD_ZREMRANGEBYSCORE = 'zremrangebyscore';
  static const CMD_ZUNIONSTORE = 'zunionstore';
  static const CMD_ZINTERSTORE = 'zinterstore';
  static const CMD_ZRANK = 'zrank';
  static const CMD_ZREVRANGE = 'zrevrange';
  static const CMD_ZSCAN = 'zscan';

  // HyperLogLog 3 commands
  static const CMD_PFADD = 'pfadd';
  static const CMD_PFCOUNT = 'pfcount';
  static const CMD_PFMERGE = 'pfmerge';

  // Pub/Sub
  static const CMD_PUBLISH = 'publish';
  static const CMD_PUBSUB = 'pubsub';

  // Transaction
  static const CMD_WATCH = 'watch';
  static const CMD_UNWATCH = 'unwatch';

  // Scripting
  static const CMD_EVAL = 'eval';
  static const CMD_EVALSHA = 'evalsha';
  static const CMD_SCRIPT = 'script';

  // Server
  static const CMD_BGREWRITEAOF = 'bgrewriteaof';
  static const CMD_CONFIG = 'config';
  static const CMD_FLUSHALL = 'flushall';
  static const CMD_SLAVEOF = 'slaveof';
  static const CMD_BGSAVE = 'bgsave';
  static const CMD_FLUSHDB = 'flushdb';
  static const CMD_SLOWLOG = 'slowlog';
  static const CMD_CLIENT = 'client';
  static const CMD_INFO = 'info';
  static const CMD_SYNC = 'sync';
  static const CMD_LASTSAVE = 'lastsave';
  static const CMD_TIME = 'time';
  static const CMD_DBSIZE = 'dbsize';
  static const CMD_DEBUG = 'debug';
  static const CMD_SAVE = 'save';
  static const CMD_SHUTDOWN = 'shutdown';

  Future send(List<String> data);
  Future _send(List<String> data);

  // Connection
  Future<String> auth(String password) => _send([CMD_AUTH, password]);

  Future<String> select(int db) => _send([CMD_AUTH, db]);

  Future<String> ping() => send([CMD_PING]);

  Future<String> echo(String message) => send([CMD_ECHO, message]);

  Future<String> quit() => send([CMD_QUIT]);

  // Key
  Future<num> del(keyOrKeys) {
    if (keyOrKeys is String) return send([CMD_DEL, keyOrKeys]);
    if (keyOrKeys is List) return send(keyOrKeys..insert(0, CMD_DEL));
  }

  Future<String> migrate(String host, int port, String key, int destinationDB,
                 num timeout, { bool copy: null, bool replace: null}) {
    List list = [CMD_MIGRATE, host, port, key, destinationDB, timeout];

    // these two parameter need redis 3.0 or above
    if (copy) list.add(PARAM_COPY);
    if (replace) list.add(PARAM_REPLACE);

    return send(list);
  }

  Future<num> pttl(String key) => send([CMD_PTTL, key]);

  Future<num> ttl(String key) => send([CMD_TTL, key]);

  Future<num> dump(String key) => send([CMD_DUMP, key]);

  Future<num> move(String key, int db) => send([CMD_MOVE, key, db]);

  Future<String> randomkey() => send([CMD_RANDOMKEY]);

  Future<String> type(String key) => send([CMD_TYPE, key]);

  Future<int> exists(String key) => send([CMD_EXISTS, key]);

  Future object(String subCommand, arg) {
    subCommand = subCommand.toLowerCase();
    if (subCommand != PARAM_REFCOUNT &&
        subCommand != PARAM_ENCODING &&
        subCommand != PARAM_IDLETIME)
      throw new IRedisException('object got invalid parameter.');
    return send([CMD_OBJECT, subCommand, arg]);
  }

  Future<String> rename(String key, String newName)
    => send([CMD_RENAME, key, newName]);

  Future<List> scan(num cursor, {String pattern: null, num count: null}) {
    List list = [CMD_SCAN, cursor];
    if (pattern != null) list.addAll([PARAM_MATCH, pattern]);
    if (count != null) list.addAll([PARAM_COUNT, count]);

    return send(list);
  }

  Future<int> expire(String key, num seconds) => send([CMD_EXPIRE, key, seconds]);

  Future<int> persist(String key) => send([CMD_PERSIST, key]);

  Future<int> renamenx(String key, String newKey)
    => send([CMD_RENAMENX, key, newKey]);

  Future<int> expireat(String key, num timestamp)
    => send([CMD_EXPIREAT, key, timestamp]);

  Future<int> pexpire(String key, num milliseconds)
    => send([CMD_PEXPIRE, key, milliseconds]);

  Future<String> restore(String key, num ttl, String value)
    => send([CMD_RESTORE, key, ttl, value]);

  Future<List> keys(String pattern) => send([CMD_KEYS, pattern]);

  Future<int> pexpireat(String key, num milliTimestamp)
    => send([CMD_PEXPIREAT, key, milliTimestamp]);

  Future<List> sort(String key, {String byPattern: null, num offset: null,
                   num count: null, List<String> getPattern: null,
                   String order: null, bool alpha: false,
                   String destinationKey: null }) {
    List list = [CMD_SORT, key];
    if (byPattern != null) list.addAll([PARAM_BY, byPattern]);
    if (offset != null && count != null) list.addAll([PARAM_LIMIT, offset, count]);

    if (getPattern != null) {
      getPattern.forEach((n) => list.addAll([PARAM_GET, n]));
    }

    if (order != null) {
      order = order.toLowerCase();
      if (order != ORDER_ASC && order != ORDER_DESC)
        throw new IRedisException('sort got invalid parameter.');
      list.add(order);
    }

    if (alpha) list.add(PARAM_ALPHA);

    if (destinationKey != null) list.addAll([PARAM_STORE, destinationKey]);

    return send(list);
  }

  // String
  Future<num> append(String key, value) => send([CMD_APPEND, key, value]);

  Future<String> set(String key, value) => send([CMD_SET, key, value]);

  Future<String> get(String key) => send([CMD_GET, key]);

  Future<String> incrbyfloat(String key, double value)
    => send([CMD_INCRBYFLOAT, key, value]);

  Future<num> setbit(String key, num offset, int value)
    => send([CMD_SETBIT, key, offset, value]);

  Future<num> bitcount(String key, num start, num end)
    => send([CMD_BITCOUNT, key, start, end]);
  Future<num> getbit(String key, num offset) => send([CMD_GETBIT, key, offset]);

  Future<String> mset(Map<String, String> map) {
    List list = [CMD_MSET];
    map.forEach((key, value) => list..add(key)..add(value));

    return send(list);
  }

  Future<List<String>> mget(List<String> list)
    => send(list..insert(0, CMD_MGET));

  Future<String> setex(String key, num seconds, value)
    => send([CMD_SETEX, key, seconds, value]);

  Future<num> bitop(String operation, String destKey, keyOrkeys) {
    operation = operation.toLowerCase();

    if (operation == OP_NOT && keyOrkeys is String)  return send([CMD_BITOP, operation, destKey, keyOrkeys]);

    if (
      (operation == OP_AND || operation == OP_OR || operation == OP_XOR) &&
      keyOrkeys is List
    ) return send(keyOrkeys..insertAll(0, [CMD_BITOP, operation, destKey]));

    throw new IRedisException('bitop got invalid parameter.');
  }

  Future<String> getrange(String key, num start, num end)
    => send([CMD_GETRANGE, key, start, end]);

  Future<num> setnx(String key, value) => send([CMD_SETNX, key, value]);

  Future<num> bitpos(String key, num start, [num end = null]) {
    if (end == null) return send([CMD_BITPOS, key, start]);

    return send([CMD_BITPOS, key, start, end]);
  }

  Future<String> getset(String key, value)
    => send([CMD_GETSET, key, value]);

  Future<num> msetnx(Map<String, String> map) {
    List list = [CMD_MSETNX];
    map.forEach((key, value) => list..add(key)..add(value));

    return send(list);
  }

  Future<num> setrange(String key, num offset, String value)
    => send([CMD_SETRANGE, key, offset, value]);

  Future<num> incr(String key) => send([CMD_INCR, key]);

  Future<num> decr(String key) => send([CMD_DECR, key]);

  Future<String> psetex(String key, num milliseconds, value)
    => send([CMD_PSETEX, key, milliseconds, value]);

  Future<num> strlen(String key) => send([CMD_STRLEN, key]);
  Future<num> decrby(String key, num value) => send([CMD_DECRBY, key, value]);

  // Hash
  Future<int> hset(String key, String field, value)
    => send([CMD_HSET, key, field, value]);

  Future<num> hdel(String key, fieldOrFields) {
    if (fieldOrFields is String) return send([CMD_HDEL, key, fieldOrFields]);

    if (fieldOrFields is List)
      return send(fieldOrFields..insertAll(0, [CMD_HDEL, key]));

    throw new IRedisException('hdel got invalid parameter.');
  }

  Future<String> hmset(String key, Map map) {
    List list = [CMD_HMSET, key];
    map.forEach((key, value) => list..add(key)..add(value));

    return send(list);
  }

  Future<num> hincrby(String key, String field, num value)
    => send([CMD_HINCRBY, key, field, value]);

  Future<List> hmget(String key, List fields)
    => send(fields..insertAll(0, [CMD_HMGET, key]));

  Future<List> hvals(String key) => send([CMD_HVALS, key]);

  Future<List> hexists(String key, String field) => send([CMD_HEXISTS, key, field]);

  Future<double> hincrbyfloat(String key, String field, double value)
    => send([CMD_HINCRBYFLOAT, key, field, value]);

  Future<List> hscan(String key, num cursor, {String pattern: null, num count: null}) {
    List list = [CMD_HSCAN, key, cursor];
    if (pattern != null) list.addAll([PARAM_MATCH, pattern]);
    if (count != null) list.addAll([PARAM_COUNT, count]);

    return send(list);
  }

  Future<String> hget(String key, String field) => send([CMD_HGET, key, field]);

  Future<List> hkeys(String key) => send([CMD_HKEYS, key]);

  Future<List> hgetall(String key) => send([CMD_HGETALL, key]);

  Future<num> hlen(String key) => send([CMD_HLEN, key]);

  Future<int> hsetnx(String key, String field, value)
    => send([CMD_HSETNX, key, field, value]);

  // List
  Future<num> rpush(String key, valueOrValues) {
    if (valueOrValues is List)
      return send(valueOrValues..insertAll(0, [CMD_RPUSH, key]));

    return send([CMD_RPUSH, key, valueOrValues]);
  }

  Future<List> blpop(keyOrKeys, [num timeout = 0]) {
    if (keyOrKeys is List)
      return send(keyOrKeys..insert(0, CMD_BLPOP)..add(timeout));

    if (keyOrKeys is String) return send([CMD_BLPOP, keyOrKeys, timeout]);

    throw new IRedisException('blpop got invalid parameter.');
  }

  Future<num> llen(String key) => send([CMD_LLEN, key]);

  Future<num> lrem(String key, num count, value)
    => send([CMD_LREM, key, count, value]);

  Future<List> brpop(keyOrKeys, [num timeout = 0]) {
    if (keyOrKeys is List)
      return send(keyOrKeys..insert(0, CMD_BRPOP)..add(timeout));

    if (keyOrKeys is String) return send([CMD_BRPOP, keyOrKeys, timeout]);

    throw new IRedisException('brpop got invalid parameter.');
  }

  Future<String> lpop(String key) => send([CMD_LPOP, key]);

  Future<String> lset(String key, num index, value)
    => send([CMD_LSET, key, index, value]);

  Future<num> rpushx(String key, value) => send([CMD_RPUSHX, key, value]);

  Future<String> rpoplpush(String source, String destination)
    => send([CMD_RPOPLPUSH, source, destination]);

  Future<String> brpoplpush(String source, String destination, [timeout = 0])
    => send([CMD_BRPOPLPUSH, source, destination, timeout]);

  Future<num> lpush(String key, valueOrValues) {
    if (valueOrValues is List)
      return send(valueOrValues..insertAll(0, [CMD_LPUSH, key]));

    return send([CMD_LPUSH, key, valueOrValues]);
  }

  Future<String> ltrim(String key, num start, num stop)
    => send([CMD_LTRIM, key, start, stop]);

  Future<String> lindex(String key, num index)
    => send([CMD_LINDEX, key, index]);

  Future<num> lpushx(String key, value) => send([CMD_LPUSHX, key, value]);

  Future<String> rpop(String key) => send([CMD_RPOP, key]);

  Future<num> linsert(String key, String pos, pivot, value) {
    pos = pos.toLowerCase();
    if (pos != PARAM_AFTER && pos != PARAM_BEFORE)
      throw new IRedisException('linsert got invalid parameter.');

    return send([CMD_LINSERT, key, pos, pivot, value]);
  }

  Future<List> lrange(String key, num start, num stop)
    => send([CMD_LRANGE, key, start, stop]);

  // Set
  Future<num> sadd(String key, valueOrValues) {
    if (valueOrValues is List) return send(valueOrValues..insertAll(0, [CMD_SADD, key]));

    return send([CMD_SADD, key, valueOrValues]);
  }

  Future<List> sinter(List keys)
    => send(keys..insert(0, CMD_SINTER));

  Future<num> smove(String source, String destination, value)
    => send([CMD_SMOVE, source, destination, value]);

  Future<List> sunion(List keys) => send(keys..insert(0, CMD_SUNION));

  Future<List> scard(String key) => send([CMD_SCARD, key]);

  Future<num> sinterstore(String destination, keyOrKeys) {
    if (keyOrKeys is List)
      return send(keyOrKeys..insertAll(0, [CMD_SINTERSTORE, destination]));

    return send([CMD_SINTERSTORE, destination, keyOrKeys]);
  }

  Future<String> spop(String key) => send([CMD_SPOP, key]);

  Future<num> sunionstore(String destination, keyOrKeys) {
    if (keyOrKeys is List)
      return send(keyOrKeys..insertAll(0, [CMD_SUNIONSTORE, destination]));

    return send([CMD_SUNIONSTORE, destination, keyOrKeys]);
  }

  Future<List> sdiff(keyOrKeys) {
    if (keyOrKeys is List)
      return send(keyOrKeys..insert(0, CMD_SDIFF));

    return send([CMD_SDIFF, keyOrKeys]);
  }

  Future<int> sismember(String key, value)
    => send([CMD_SISMEMBER, key, value]);

  Future<List> srandmember(String key, [num count = null]) {
    if (count is num) return send([CMD_SRANDMEMBER, key, count]);

    return send([CMD_SRANDMEMBER, key]);
  }

  Future<List> sscan(String key, num cursor, {String pattern: null, num count: null}) {
    List list = [CMD_SSCAN, key, cursor];
    if (pattern != null) list.addAll([PARAM_MATCH, pattern]);
    if (count != null) list.addAll([PARAM_COUNT, count]);

    return send(list);
  }

  Future<num> sdiffstore(String destination, keyOrKeys) {
    if (keyOrKeys is List)
      return send(keyOrKeys..insertAll(0, [CMD_SDIFFSTORE, destination]));

    return send([CMD_SDIFFSTORE, destination, keyOrKeys]);
  }

  Future<List> smembers(String key) => send([CMD_SMEMBERS, key]);

  Future<num> srem(String key, valueOrValues) {
    if (valueOrValues is List)
      return send(valueOrValues..insertAll(0, [CMD_SREM, key]));

    return send([CMD_SREM, key, valueOrValues]);
  }

  // Sorted Set
  Future<num> zadd(String key, Map<String, num> map) {
    List list = [CMD_ZADD, key];
    map.forEach((key, score) => list..add(score)..add(key));

    return send(list);
  }

  Future<num> zlexcount(String key, String min, String max)
    => send([CMD_ZLEXCOUNT, key, min, max]);

  Future<num> zrem(String key, memOrMems) {
    if (memOrMems is List)
      return send(memOrMems..insertAll(0, [CMD_ZREM, key]));

    return send([CMD_ZREM, key, memOrMems]);
  }

  Future<List> zrevrangebyscore(String key, String max, String min,
                                {bool withScores: false,
                                num offset: null, num count: null}) {
    List list = [CMD_ZREVRANGEBYSCORE, key, max, min];
    if (withScores) list.add(PARAM_WITHSCORES);
    if (offset != null && count != null)
      list.addAll([PARAM_LIMIT, offset, count]);

    return send(list);
  }

  Future<num> zcard(String key) => send([CMD_ZCARD, key]);

  Future<List> zrange(String key, String start, String stop,
                    {bool withScores: false}) {
    List list = [CMD_ZRANGE, key, start, stop];
    if (withScores) list.add(PARAM_WITHSCORES);
    return send(list);
  }

  Future<num> zremrangebylex(String key, String min, String max)
    => send([CMD_ZREMRANGEBYLEX, key, min, max]);

  Future<num> zrevrank(String key, value) => send([CMD_ZREVRANK, key, value]);

  Future<num> zcount(String key, String min, String max)
    => send([CMD_ZCOUNT, key, min, max]);

  Future<List> zrangebylex(String key, String min, String max,
                                {num offset: null, num count: null}) {
    List list = [CMD_ZRANGEBYLEX, key, min, max];
    if (offset != null && count != null)
      list.addAll([PARAM_LIMIT, offset, count]);

    return send(list);
  }

  Future<num> zremrangebyrank(String key, num start, num stop)
    => send([CMD_ZREMRANGEBYRANK, key, start, stop]);

  Future<num> zscore(String key, member)
    => send([CMD_ZSCORE, key, member]);

  Future<String> zincrby(String key, num increment, String member)
    => send([CMD_ZINCRBY, key, increment, member]);

  Future<List> zrangebyscore(String key, String min, String max,
                                {bool withScores: false,
                                num offset: null, num count: null}) {
    List list = [CMD_ZRANGEBYSCORE, key, min, max];
    if (withScores) list.add(PARAM_WITHSCORES);
    if (offset != null && count != null)
      list.addAll([PARAM_LIMIT, offset, count]);

    return send(list);
  }

  Future<num> zremrangebyscore(String key, String min, String max)
    => send([CMD_ZREMRANGEBYSCORE, key, min, max]);

  Future<num> zunionstore(String destination, List keys, {List weights: null,
                        String aggregate: AGGREGATE_SUM}) {
    List list = [CMD_ZUNIONSTORE, destination, keys.length];
    list.addAll(keys);
    if (weights is List) {
      if (weights.length != keys.length) {
        throw new IRedisException('zunionstore got invalid parameter.');
      }
      list..add(PARAM_WEIGHTS)..addAll(weights);
    }

    if (aggregate != AGGREGATE_SUM) {
      if (aggregate != AGGREGATE_MAX && aggregate != AGGREGATE_MIN) {
        throw new IRedisException('zunionstore got invalid parameter.');
      }
      list..add(PARAM_AGGREGATE)..add(aggregate);
    }

    return send(list);
  }

  Future<num> zinterstore(String destination, List keys, {List weights: null,
                        String aggregate: AGGREGATE_SUM}) {
    List list = [CMD_ZINTERSTORE, destination, keys.length];
    list.addAll(keys);
    if (weights is List) {
      if (weights.length != keys.length) {
        throw new IRedisException('zunionstore got invalid parameter.');
      }
      list..add(PARAM_WEIGHTS)..addAll(weights);
    }

    if (aggregate != AGGREGATE_SUM) {
      if (aggregate != AGGREGATE_MAX && aggregate != AGGREGATE_MIN) {
        throw new IRedisException('zunionstore got invalid parameter.');
      }
      list..add(PARAM_AGGREGATE)..add(aggregate);
    }

    return send(list);
  }

  Future<num> zrank(String key, member)
    => send([CMD_ZRANK, key, member]);

  Future<List> zrevrange(String key, String start, String stop,
                      {bool withScores: false}) {
    List list = [CMD_ZREVRANGE, key, start, stop];
    if (withScores) list.add(PARAM_WITHSCORES);
    return send(list);
  }

  Future<List> zscan(String key, num cursor, {String pattern: null, num count: null}) {
    List list = [CMD_ZSCAN, key, cursor];
    if (pattern != null) list.addAll([PARAM_MATCH, pattern]);
    if (count != null) list.addAll([PARAM_COUNT, count]);

    return send(list);
  }

  // HyperLogLog
  Future<num> pfadd(String key, valueOrValues) {
    if (valueOrValues is List)
      return send(valueOrValues..insertAll(0, [CMD_PFADD, key]));
    return send([CMD_PFADD, key, valueOrValues]);
  }

  Future<num> pfcount(keyOrKeys) {
    if (keyOrKeys is List) return send(keyOrKeys..insert(0, CMD_PFCOUNT));
    return send([CMD_PFCOUNT, keyOrKeys]);
  }

  Future<String> pfmerge(String destination, keyOrKeys) {
    if (keyOrKeys is List)
      return send(keyOrKeys..insertAll(0, [CMD_PFMERGE, destination]));
    return send([CMD_PFMERGE, destination, keyOrKeys]);
  }

  // Pub/Sub
  Future<String> subscribe(String channel, Function onData,
                           { Function onDone: null });

  Future<String> unsubscribe(String channel);

  Future<String> psubscribe(String pattern, Function onData,
                            { Function onDone: null });

  Future<String> punsubscribe(String pattern);

  Future<num> publish(String channel, String message)
    => send([CMD_PUBLISH, channel, message]);

  Future pubsub(String type, [param]) {
    type = type.toLowerCase();
    if (type == PARAM_CHANNELS) return send([CMD_PUBSUB, type, param]);

    if (type == PARAM_NUMSUB) {
      if (param is List)
        return send(param..insertAll(0, [CMD_PUBSUB, type]));

      return send([CMD_PUBSUB, type, param]);
    }

    if (type == PARAM_NUMPAT) return send([CMD_PUBSUB, type]);

    throw new IRedisException('pubsub got invalid parameter.');
  }

  // Transaction
  Future multi();

  Future exec();

  Future discard();

  Future watch(keyOrKeys) {
    if (keyOrKeys is String) return send([CMD_WATCH, keyOrKeys]);
    if (keyOrKeys is List) return send(keyOrKeys..insert(0, CMD_WATCH));
  }

  Future unwatch() => send([CMD_UNWATCH]);

  // Scripting
  Future eval(String script, [Map args = null]) {
    if (args == null) args = {};
    List list = [CMD_EVAL, script, args.length];

    if (args.length != 0) list..addAll(args.keys)..addAll(args.values);

    return send(list);
  }

  Future evalsha(String sha1, [Map args = null]) {
    if (args == null) args = {};
    List list = [CMD_EVALSHA, sha1, args.length];

    if (args.length != 0) list..addAll(args.keys)..addAll(args.values);

    return send(list);
  }

  Future scriptExists(scriptOrScripts) {
    if (scriptOrScripts is List)
      return send(scriptOrScripts..insertAll(0, [CMD_SCRIPT, PARAM_EXISTS]));

    return send([CMD_SCRIPT, PARAM_EXISTS, scriptOrScripts]);
  }

  Future scriptKill() => send([CMD_SCRIPT, PARAM_KILL]);

  Future scriptFlush() => send([CMD_SCRIPT, PARAM_FLUSH]);

  Future scriptLoad(String script) => send([CMD_SCRIPT, PARAM_LOAD, script]);

  // Server
  Future<String> bgrewriteaof() => send([CMD_BGREWRITEAOF]);

  Future<List> configGet(String param) => send([CMD_CONFIG, PARAM_GET, param]);

  Future<String> flushall() => send([CMD_FLUSHALL]);

  Future<String> flushdb() => send([CMD_FLUSHDB]);

  Future<String> slaveof(String host, int port) => send([CMD_SLAVEOF, host, port]);

  Future<String> slaveofNoOne() => send([CMD_SLAVEOF, PARAM_NO, PARAM_ONE]);

  Future<String> bgsave() => send([CMD_BGSAVE]);

  Future<String> configRewrite() => send([CMD_CONFIG, PARAM_REWRITE]);

  Future slowlog(String subcommand, [num arg = null]) {
    subcommand = subcommand.toLowerCase();
    if (subcommand == PARAM_LEN) return send([CMD_SLOWLOG, PARAM_LEN]);
    if (subcommand == PARAM_RESET) return send([CMD_SLOWLOG, PARAM_RESET]);
    if (subcommand == PARAM_GET && arg != null)
      return send([CMD_SLOWLOG, PARAM_GET, arg]);

    throw new IRedisException('slowlog got invalid parameter.');
  }

  Future<String> clientKill(String ipAndPort)
    => send([CMD_CLIENT, PARAM_KILL, ipAndPort]);

  Future<String> configSet(String param, String value)
    => send([CMD_CONFIG, PARAM_SET, param, value]);

  Future<String> info() => send([CMD_INFO]);

  Future<String> clientList() => send([CMD_CLIENT, PARAM_LIST]);

  Future<String> configResetstat() => send([CMD_CONFIG, PARAM_RESETSTAT]);

  Future<num> lastsave() => send([CMD_LASTSAVE]);

  Future<List> time() => send([CMD_TIME]);

  Future<String> clientGetname() => send([CMD_CLIENT, PARAM_GETNAME]);

  Future<num> dbsize() => send([CMD_DBSIZE]);

  Future<String> clientPause(num milliseconds)
    => send([CMD_CLIENT, PARAM_PAUSE, milliseconds]);

  Future<String> debugObject(String key)
    => send([CMD_DEBUG, PARAM_OBJECT, key]);

  Future<String> save() => send([CMD_SAVE]);

  Future<String> clientSetname(String name)
    => send([CMD_CLIENT, PARAM_SETNAME, name]);

  Future<String> debugSegfault() => send([CMD_DEBUG, PARAM_SEGFAULT]);

  Future<String> shutdown(String param) {
    param = param.toLowerCase();
    if (param != PARAM_SAVE &&
        param != PARAM_NOSAVE &&
        param != PARAM_ABORT
    ) throw new IRedisException('shutdown got invalid parameter.');

    return send([CMD_SHUTDOWN, param]);
  }

  Future<String> sync() => send([CMD_SYNC]);

  Future monitor();
}
