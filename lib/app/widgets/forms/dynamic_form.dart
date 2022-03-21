import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicForm extends GetView {
  const DynamicForm({
    Key? key,
    required this.inputs,
  }) : super(key: key);

  final Iterable<FormInputData> inputs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final input in inputs) buildInput(context, input),
      ],
    );
  }

  Widget buildInput<T>(BuildContext context, FormInputData<T> input) {
    switch (input.data.runtimeType) {
      case FormTextInputData:
        final data = input.data as FormTextInputData;

        return TextFormField(
          controller: data.controller,
          decoration: InputDecoration(
            hintText: data.hintText,
            label: Text(data.label),
          ),
        );
      case FormDropdownInputData:
        final data = input.data as FormDropdownInputData;
        return DropdownButton(
          items: data.items.toList(),
          onChanged: data.onChange,
        );
      default:
        throw UnsupportedError('Form input type `$T` is not supported.');
    }
  }
}

enum FormInputType {
  text,
  dropdown,
}

class FormInputData<T> {
  FormInputData({
    required this.name,
    required this.data,
  });

  final String name;
  final T data;
}

abstract class DynamicFormController extends GetxController {
  abstract final RxList<FormInputData> inputs;
}

class FormTextInputData {
  FormTextInputData({
    required this.label,
    required this.text,
    this.hintText,
  });

  final String label;
  final String text;
  final String? hintText;
  late final controller = TextEditingController(text: text);
}

class FormDropdownInputData<T> {
  FormDropdownInputData({
    required this.value,
    required this.items,
  });

  final T value;
  final Iterable<DropdownMenuItem<T>> items;
  late final controller = ValueNotifier<T>(value);

  onChange(T value) {
    controller.value = value;
  }
}
