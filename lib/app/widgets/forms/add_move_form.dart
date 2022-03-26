import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/generated/l10n.dart';
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
      builder: (context, inputs) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8).copyWith(bottom: 8),
          children: [
            Row(
              children: [
                Expanded(child: inputs[0], flex: 2),
                const SizedBox(width: 16),
                inputs[1],
              ],
            ),
            const SizedBox(height: 8),
            for (final input in inputs.sublist(2))
              Padding(padding: const EdgeInsets.only(bottom: 8), child: input),
          ],
        );
      },
    );
  }
}

class AddMoveFormController extends DynamicFormController<Move> {
  @override
  void onInit() {
    createInputs();
    super.onInit();
  }

  @override
  final entity = Move.empty().obs;

  @override
  Move setData(Map<String, dynamic> data, [Iterable<String>? classKeys]) {
    entity.value = entity.value.copyWithInherited(
      name: data['name'],
      category: data['category'],
      description: data['description'],
      explanation: data['explanation'],
      classKeys: [
        ...<String>{...entity.value.classKeys, ...(classKeys ?? [])}
      ],
    );

    return entity.value;
  }

  @override
  late final List<FormInputData> inputs;

  createInputs() {
    inputs = <FormInputData>[
      FormInputData<FormTextInputData>(
        name: 'name',
        data: FormTextInputData(
          label: 'Move name',
          textCapitalization: TextCapitalization.words,
          text: entity.value.name,
        ),
      ),
      FormInputData(
        name: 'category',
        data: FormDropdownInputData(
          value: entity.value.category,
          label: const Text('Category'),
          items: MoveCategory.values.map(
            (cat) => DropdownMenuItem(
              child: Text(S.current.moveCategoryWithLevelShort(cat.name)),
              value: cat,
            ),
          ),
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'description',
        data: FormTextInputData(
          label: 'Move description',
          maxLines: 5,
          minLines: 5,
          textCapitalization: TextCapitalization.sentences,
          text: entity.value.description,
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'explanation',
        data: FormTextInputData(
          label: 'Move explanation',
          maxLines: 5,
          minLines: 5,
          textCapitalization: TextCapitalization.sentences,
          text: entity.value.explanation,
        ),
      ),
      FormInputData<FormTagsInputData>(
        name: 'tags',
        data: FormTagsInputData(value: entity.value.tags),
      ),
    ];
  }
}
