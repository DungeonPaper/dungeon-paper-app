import 'package:dungeon_paper/app/widgets/forms/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNoteForm extends GetView<AddNoteController> {
  const AddNoteForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicForm(inputs: controller.inputs);
  }
}

class AddNoteController extends GetxController {
  final inputs = <FormInputData>[
    FormInputData(name: 'title', data: FormTextInputData(label: 'Title', text: '')),
  ].obs;
}
