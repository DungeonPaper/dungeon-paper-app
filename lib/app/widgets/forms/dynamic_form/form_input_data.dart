import 'dart:async';

import 'package:dungeon_paper/core/utils/streams.dart';
import 'package:flutter/material.dart';

enum FormInputType {
  text,
  dropdown,
}

abstract class BaseInputData<T> extends Stream<T> {
  void dispose();
  T get value;
}

class FormInputData<T extends BaseInputData> {
  FormInputData({
    required this.name,
    required this.data,
  });

  final String name;
  final T data;
}

class FormTextInputData extends BaseInputData<String> {
  FormTextInputData({
    required this.label,
    required this.text,
    this.hintText,
    this.minLines,
    this.maxLines,
  }) {
    init();
  }

  final String label;
  final String text;
  final String? hintText;
  final int? minLines;
  final int? maxLines;

  late final TextEditingController controller;
  late final TextEditingControllerStream stream;
  late final StreamSubscription subscription;

  void init() {
    controller = TextEditingController(text: text);
    stream = TextEditingControllerStream(controller);
  }

  @override
  StreamSubscription<String> listen(
    void Function(String event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  @override
  void dispose() {
    stream.dispose();
  }

  @override
  String get value => controller.text;
}

class FormDropdownInputData<T> extends BaseInputData {
  FormDropdownInputData({
    required this.value,
    required this.items,
  });

  @override
  final T value;

  final Iterable<DropdownMenuItem<T>> items;

  late final ValueNotifier<T> controller;
  late final ValueNotifierStream<T> stream;
  late final StreamSubscription subscription;

  void init() {
    controller = ValueNotifier(value);
    stream = ValueNotifierStream<T>(controller);
  }

  @override
  StreamSubscription listen(void Function(dynamic event)? onData,
          {Function? onError, void Function()? onDone, bool? cancelOnError}) =>
      stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  @override
  void dispose() {
    stream.dispose();
  }
}
