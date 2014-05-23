import 'dart:async';
import 'package:logging/logging.dart';

import '../i_redis.dart';
import 'lib_test.dart';


/*
  Test Preparation

  Redis version need v2.8.9 or above

  open Redis instance 127.0.0.1 6379 without password
  open Redis instance 127.0.0.1 6380 with password '123'
 */

main() {
  Logger.root.level = Level.FINE;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  IRedis handler1 = new IRedis();
  IRedis handler2 = new IRedis();
  IRedis handler3 = new IRedis(port: 6380);
  IRedis handler4 = new IRedis();
  IRedis handler5 = new IRedis();

  List waitList = [];
  waitList.add(handler1.connect());
  waitList.add(handler2.connect());
  waitList.add(handler3.connect());
  waitList.add(handler4.connect());
  waitList.add(handler5.connect());

  Future.wait(waitList).then((_) {
    testSpecial(handler1);
    testKey(handler1, handler3);
    testConnect();
    testString(handler1);
    testHash(handler1);
    testList(handler1);
    testSet(handler1);
    testSortedSet(handler1);
    testHyperLogLog(handler1);
    testPubSub(handler4, handler5);
    testTransaction(handler1);
    testScripting(handler1);
    testServer(handler1, handler2);
  });
}