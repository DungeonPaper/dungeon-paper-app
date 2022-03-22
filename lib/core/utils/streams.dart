import 'dart:async';

import 'package:flutter/widgets.dart';

class ValueNotifierStream<T> extends Stream<T> {
  final ValueNotifier<T> notifier;
  final controller = StreamController<T>();

  ValueNotifierStream(this.notifier) {
    init();
  }

  void init() {
    notifier.addListener(listener);
  }

  void dispose() {
    notifier.removeListener(listener);
  }

  void listener() {
    controller.add(notifier.value);
  }

  @override
  StreamSubscription<T> listen(void Function(T event)? onData,
          {Function? onError, void Function()? onDone, bool? cancelOnError}) =>
      controller.stream
          .asBroadcastStream()
          .listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}

class TextEditingControllerStream extends Stream<String> {
  final TextEditingController textController;
  final controller = StreamController<String>();

  TextEditingControllerStream(this.textController) {
    init();
  }

  @override
  StreamSubscription<String> listen(void Function(String event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return controller.stream
        .asBroadcastStream()
        .listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  void init() {
    textController.addListener(listener);
  }

  void dispose() {
    textController.removeListener(listener);
  }

  void listener() {
    controller.add(textController.text);
  }
}
