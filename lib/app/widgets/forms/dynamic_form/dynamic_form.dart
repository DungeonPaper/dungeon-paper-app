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
    this.builder = _defaultBuilder,
  }) : super(key: key);

  final Iterable<FormInputData> inputs;
  final void Function(Map<String, dynamic> data) onChange;
  final Widget Function(BuildContext context, List<Widget> inputs) builder;

  static Widget _defaultBuilder(BuildContext context, List<Widget> inputs) => ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 8),
        children: [
          for (final input in inputs)
            Padding(padding: const EdgeInsets.only(bottom: 8), child: input),
        ],
      );

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
      debugPrint('listener for ${input.name}');
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
        debugPrint('sending $data');
        widget.onChange(data);
      };

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      widget.inputs.map((input) => input.build(context)).toList(),
    );
  }
}

abstract class DynamicFormController<T> extends GetxController {
  abstract final Rx<T> entity;
  T setData(Map<String, dynamic> data);
  abstract final List<FormInputData> inputs;
}
