import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMoveForm extends GetView<AddMoveFormController> {
  const AddMoveForm({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final void Function(Move move) onSave;

  @override
  Widget build(BuildContext context) {
    return DynamicForm(inputs: controller.inputs);
  }
}

class AddMoveFormController extends GetxController {
  final inputs = <FormInputData>[
    FormInputData<FormTextInputData>(
      name: 'title',
      data: FormTextInputData(label: 'Title', text: ''),
    ),
  ].obs;
}
