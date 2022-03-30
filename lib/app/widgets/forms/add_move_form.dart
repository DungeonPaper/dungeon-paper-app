import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/repository_item_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMoveForm extends GetView<AddMoveFormController> {
  const AddMoveForm({
    Key? key,
    required this.onChange,
    required this.classKey,
    required this.type,
  }) : super(key: key);

  final void Function(Move move) onChange;
  final List<String> classKey;
  final ItemFormType type;

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      inputs: controller.inputs,
      onChange: (d) => onChange(controller.setData(d)),
      builder: (context, inputs) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 70),
          children: [
            inputs[0],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: inputs[1]),
                const SizedBox(width: 16),
                Expanded(child: inputs[2]),
              ],
            ),
            const SizedBox(height: 16),
            for (final input in inputs.sublist(3))
              Padding(padding: const EdgeInsets.only(bottom: 16), child: input),
          ],
        );
      },
    );
  }
}

class AddMoveFormController extends DynamicFormController<Move> {
  AddMoveFormController({required this.move});

  final Move? move;

  @override
  void onInit() {
    if (move != null) {
      entity.value = move!.copyWithInherited(
        meta: move!.meta.copyWith(
          sharing: MetaSharing.createFork(move!.key, move!.meta.sharing, outOfSync: false),
        ),
      );
      setData({
        'name': move!.name,
        'category': move!.category,
        'description': move!.description,
        'explanation': move!.explanation,
        'tags': move!.tags,
        'dice': move!.dice,
        'classKeys': move!.classKeys,
      });
    }
    createInputs();
    super.onInit();
  }

  @override
  final entity = Move.empty().obs;

  @override
  Move setData(Map<String, dynamic> data) {
    entity.value = entity.value.copyWithInherited(
      meta: entity.value.meta.copyWith(
        sharing: MetaSharing.createFork(move!.key, move!.meta.sharing, outOfSync: true),
      ),
      name: data['name'],
      category: data['category'],
      description: data['description'],
      explanation: data['explanation'],
      tags: data['tags'],
      dice: data['dice'],
      classKeys: data['classKeys'] is List ? data['classKeys'] : [data['classKeys']],
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
      FormInputData(
        name: 'classKeys',
        data: FormDropdownInputData(
          isExpanded: true,
          value: entity.value.classKeys.isNotEmpty ? entity.value.classKeys[0] : null,
          label: const Text('Class'),
          items: {...repo.builtIn.classes.values, ...repo.my.classes.values}.map(
            (cls) => DropdownMenuItem(
              child: Text(cls.name),
              value: cls.key,
            ),
          ),
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'description',
        data: FormTextInputData(
          label: 'Move description',
          maxLines: 10,
          minLines: 5,
          rich: true,
          textCapitalization: TextCapitalization.sentences,
          text: entity.value.description,
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'explanation',
        data: FormTextInputData(
          label: 'Move explanation',
          maxLines: 10,
          minLines: 5,
          rich: true,
          textCapitalization: TextCapitalization.sentences,
          text: entity.value.explanation,
        ),
      ),
      FormInputData<FormDicesInputData>(
        name: 'dice',
        data: FormDicesInputData(value: entity.value.dice),
      ),
      FormInputData<FormTagsInputData>(
        name: 'tags',
        data: FormTagsInputData(value: entity.value.tags),
      ),
    ];
  }
}
