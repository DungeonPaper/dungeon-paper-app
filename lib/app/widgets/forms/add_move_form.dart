import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMoveForm extends GetView<AddMoveFormController> {
  const AddMoveForm({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  final void Function(Move move) onChange;

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      inputs: controller.inputs,
      onChange: (d) => debugPrint('addMoveForm onChange $d'),
    );
  }
}

class AddMoveFormController extends GetxController {
  final inputs = <FormInputData>[
    FormInputData<FormTextInputData>(
      name: 'name',
      data: FormTextInputData(label: 'Move name', text: ''),
    ),
  ].obs;
}
