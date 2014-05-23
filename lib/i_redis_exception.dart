part of i_redis;

class IRedisException implements Exception {
  String message;
  IRedisException(this.message) {
    ILog.severe(message);
  }
  String toString() => "IRedisException: $message";
}
