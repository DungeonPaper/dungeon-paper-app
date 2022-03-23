import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMoveForm extends GetView<AddMoveFormController> {
  const AddMoveForm({
    Key? key,
    required this.onChange,
    required this.classKey,
  }) : super(key: key);

  final void Function(Move move) onChange;
  final String classKey;

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      inputs: controller.inputs,
      onChange: (d) => onChange(controller.setData(d, [classKey])),
    );
  }
}

class AddMoveFormController extends DynamicFormController<Move> {
  @override
  final entity = Move.empty().obs;

  @override
  Move setData(Map<String, dynamic> data, [Iterable<String>? classKeys]) {
    entity.value = entity.value.copyWithInherited(
      name: data['name'],
      // category: data['category'],
      description: data['description'],
      explanation: data['explanation'],
      classKeys: [
        ...<String>{...entity.value.classKeys, ...(classKeys ?? [])}
      ],
    );

    return entity.value;
  }

  @override
  final inputs = <FormInputData>[
    FormInputData<FormTextInputData>(
      name: 'name',
      data: FormTextInputData(
        label: 'Move name',
        textCapitalization: TextCapitalization.words,
      ),
    ),
    FormInputData<FormTextInputData>(
      name: 'description',
      data: FormTextInputData(
        label: 'Move description',
        maxLines: 5,
        minLines: 5,
        textCapitalization: TextCapitalization.sentences,
      ),
    ),
    FormInputData<FormTextInputData>(
      name: 'explanation',
      data: FormTextInputData(
        label: 'Move explanation',
        maxLines: 5,
        minLines: 5,
        textCapitalization: TextCapitalization.sentences,
      ),
    ),
  ].obs;
}
