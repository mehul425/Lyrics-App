import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

Future<void> main() async {
  Api api = Api();

  var streamSubscription = api.getData().listen((event) {
    if (kDebugMode) {
      print("ok1 $event");
    }
  });

  await Future.delayed(const Duration(seconds: 1));
  streamSubscription.cancel();
  await Future.delayed(const Duration(seconds: 1));
  api.getData().listen((event) {
    if (kDebugMode) {
      print("ok2 $event");
    }
  });
}

class Api {
  ReplayStream<int>? stream;

  Api() {
    stream = Future.delayed(const Duration(seconds: 2),() => 1,).asStream().shareReplay();
  }

  Stream<int> getData() => stream!;
}
