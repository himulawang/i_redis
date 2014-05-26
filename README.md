i_redis
===

This is a redis client for dart.

##Install

### Depend on it

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  i_redis: ">=1.0.0 <2.0.0"
```

### Install it

```sh
pub get
```

##Usage

```dart
import 'package:i_redis/i_redis.dart';

IRedis handler = new IRedis(host: '192.168.0.1', port: 6379);
handler.connect()
.then((_) {
  print('now we connected');
  return handler.set('myKey', 'myValue');
}))
.then((result) {
  print(result);
}));
```

##API

Example:

```dart
handler.hmget('testHmget', ['field1', 'field4'])
.then(expectAsync((result) {
  expect(result, ['value1', null]);
}));
```
You can find every api in test/test_*.dart file.

##Document

[LINK](http://himulawang.github.io/i_redis/#i_redis.IRedis)

##TODO

Use [hiredis](https://github.com/redis/hiredis) to replace IRESP decoder. [Article](https://www.dartlang.org/articles/native-extensions-for-standalone-dart-vm/)

##License

Copyright (C) 2014 ila

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
