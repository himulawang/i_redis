part of i_redis;

class IRESPCodec extends Codec {
  const IRESPCodec();

  String encode(List data) {
    return new IRESPEncoder().convert(data);
  }
  List decode(List data) {
    return [];
  }

  IRESPEncoder get encoder => new IRESPEncoder();
  IRESPEncoder get decoder => new IRESPEncoder();
}

