part of i_redis;

class IRESPDecoder extends Converter {
  static const int CR = 13;
  static const int LF = 10;

  static const int SIMPLE_STRING = 43;    // -
  static const int ERROR = 45;            // +
  static const int INTEGER = 58;          // :
  static const int BULK_STRING = 36;      // $
  static const int ARRAY = 42;            // *

  Function _onParsed;
  Function _onError;

  Uint8List _buffer = null;
  num _offset = 0;

  String convert(List data) {
    allocate(data);
    num rollbackOffset;

    while (true) {
      rollbackOffset = _offset;
      // at least 4 bytes: :1\r\n
      if (_getRemainBytesLength() < 4) break;

      int type = _buffer[_offset++];

      try {
        if (type == BULK_STRING) {
          var reply = parse(type);
          if (reply == null) break;
          if (reply is INil) reply = null;
          _onParsed(reply);
        } else if (type == ARRAY) {
          rollbackOffset = _offset - 1;
          var reply = parse(type);
          _onParsed(reply);
        } else if (type == SIMPLE_STRING || type == INTEGER) {
          var reply = parse(type);
          if (reply == null) break;
          _onParsed(reply);
        } else if (type == ERROR) {
          var reply = parse(type);
          if (reply == null) break;
          _onError(reply);
        }
      } catch (e) {
        if (e is! IRedisException) throw e;
        _offset = rollbackOffset;
        break;
      }
    }
  }

  parse(int type) {
    num start, end, offset, valueLength;

    // we put useful type up side to optimize the process flow
    if (type == BULK_STRING) {
      num rollbackOffset = _offset - 1;
      num valueLength = _getBulkLength();

      // if length is -1 means redis return null
      if (valueLength == -1) return new INil();

      start = _offset;
      end = _offset + valueLength;

      _offset = end + 2;

      if (end > _buffer.length) {
        _offset = rollbackOffset;
        throw new IRedisException('Incomplete buffer');
      }

      return bufferToString(_buffer.sublist(start, end));
    } else if (type == ARRAY) {
      offset = _offset;
      valueLength = _getBulkLength();

      if (valueLength < 0) return null;

      if (valueLength > _getRemainBytesLength()) {
        _offset = offset - 1;
        throw new IRedisException('Incomplete buffer');
      }

      List reply = [];
      offset = _offset - 1;
      int eleType;
      var result;

      for (num i = 0; i < valueLength; ++i) {
        eleType = _buffer[_offset++];

        if (_offset > _buffer.length) throw new IRedisException('Incomplete buffer');
        result = parse(eleType);
        if (result is INil) result = null;
        reply.add(result);
      }

      return reply;
    } else if (type == SIMPLE_STRING || type == ERROR) {
      start = _offset;
      end = _getEndOffset() - 1;

      _offset = end + 2;
      return bufferToString(_buffer.sublist(start, end));
    } else if (type == INTEGER) {
      start = _offset;
      end = _getEndOffset() - 1;

      _offset = end + 2;
      return int.parse(new String.fromCharCodes(_buffer.sublist(start, end)));
    }
  }

  num _getEndOffset() {
    num offset = _offset;
    do {
      ++offset;
      if (offset >= _buffer.length) throw new IRedisException('Incomplete buffer');
    } while (_buffer[offset - 1] != CR && _buffer[offset] != LF);

    return offset;
  }

  num _getBulkLength() {
    num end = this._getEndOffset();
    Uint8List view = _buffer.sublist(_offset, end);
    String value = new String.fromCharCodes(view);
    _offset = end + 1;
    return int.parse(value);
  }

  num _getRemainBytesLength()
    => (_buffer.length - _offset) < 0 ? 0 : (_buffer.length - _offset);

  void allocate(Uint8List data) {
    if (_buffer == null) {
      _buffer = data;
      return;
    }

    // out of data
    if (_offset >= _buffer.length) {
      _buffer = data;
      _offset = 0;
      return;
    }

    num preLength = _getRemainBytesLength();
    num newLength = preLength + data.length;
    Uint8List newBuffer = new Uint8List(newLength);
    newBuffer
      ..setRange(0, _getRemainBytesLength() - 1, _buffer.sublist(_offset))
      ..setRange(_getRemainBytesLength() - 1, newLength - 1, data);

    _buffer = newBuffer;

    _offset = 0;
  }

  bufferToString(List data) {
    String str;

    try {
      str = UTF8.decode(data);
    } catch (e) {
      str = new String.fromCharCodes(data);
    }
    return str;
  }

  reset() {
    _buffer = null;
    _offset = 0;
  }

  bindOnParsed(Function onParsed) => _onParsed = onParsed;
  bindOnParserError(Function onError) => _onError = onError;
}
