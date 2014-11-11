part of i_redis;

class IRESPEncoder extends Converter {
  static const String DELIMITER = '\r\n';

  convert(List data) {
    String cmd = data.removeAt(0);

    BytesBuilder bb = new BytesBuilder();
    bb.add('*${data.length + 1}${DELIMITER}\$${cmd.length}${DELIMITER}${cmd}${DELIMITER}'.codeUnits);

    data.forEach((v) {
      if (v is! String) v = v.toString();
      Uint8List utf8 = new Uint8List.fromList(UTF8.encode(v));
      bb..add('\$${utf8.length}${DELIMITER}'.codeUnits)
        ..add(utf8)
        ..add(DELIMITER.codeUnits);
    });

    return bb.takeBytes();
  }

  /*
  IRESPSink startChunkedConversion(sink) {
    return new IRESPSink(sink);
  }
  */
}
