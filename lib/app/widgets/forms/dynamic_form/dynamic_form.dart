import 'dart:async';

import 'package:dungeon_paper/core/utils/streams.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'form_input_data.dart';

class DynamicForm extends StatefulWidget {
  const DynamicForm({
    Key? key,
    required this.inputs,
    required this.onChange,
  }) : super(key: key);

  final Iterable<FormInputData> inputs;
  final void Function(Map<String, dynamic> data) onChange;

  @override
  State<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  late List<StreamSubscription> listeners;
  late Map<String, dynamic> data;

  @override
  void initState() {
    listeners = [];
    for (final input in widget.inputs) {
      listeners.add(input.data.listen(_sendUpdate(input.name)));
    }
    data = {
      for (final input in widget.inputs) input.name: input.data.value,
    };
    super.initState();
  }

  @override
  void dispose() {
    for (final listener in listeners) {
      listener.cancel();
    }
    super.dispose();
  }

  void Function(dynamic item) _sendUpdate(String name) => (dynamic item) {
        setState(() {
          data[name] = item;
        });
        widget.onChange(data);
      };

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 8),
      children: [
        for (final input in widget.inputs) input.build(context),
      ],
    );
  }
}

abstract class DynamicFormController<T> extends GetxController {
  abstract final Rx<T> entity;
  T setData(Map<String, dynamic> data);
  abstract final List<FormInputData> inputs;
}
