import 'dart:async';

import 'package:flutter/widgets.dart';

class ValueNotifierStream<T> extends Stream<T> {
  final ValueNotifier<T> notifier;
  final controller = StreamController<T>.broadcast();

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
  StreamSubscription<T> listen(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      controller.stream
          .asBroadcastStream()
          .listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}

class TextEditingControllerStream extends Stream<String> {
  final TextEditingController textController;
  late final StreamController<String> controller;
  late final Stream<String> stream;

  TextEditingControllerStream(this.textController) {
    init();
  }

  @override
  StreamSubscription<String> listen(
    void Function(String event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  void init() {
    controller = StreamController.broadcast();
    stream = controller.stream.asBroadcastStream();
    textController.addListener(listener);
  }

  void dispose() {
    textController.removeListener(listener);
  }

  void listener() {
    // debugPrint('Sending: ${textController.text}');
    controller.add(textController.text);
  }
}
