import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/repository_item_form.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSpellForm extends GetView<AddSpellFormController> {
  const AddSpellForm({
    Key? key,
    required this.onChange,
    required this.type,
  }) : super(key: key);

  final void Function(Spell spell) onChange;
  final ItemFormType type;

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      inputs: controller.inputs,
      onChange: (d) => onChange(controller.setData(d)),
    );
  }
}

class AddSpellFormController extends DynamicFormController<Spell> {
  AddSpellFormController({required this.spell, required this.rollStats});

  final Spell? spell;
  final RollStats rollStats;

  @override
  void init() {
    if (spell != null) {
      entity.value = spell!.copyWithInherited(
        meta: spell!.meta.copyWith(
          sharing: MetaSharing.createFork(spell!.key, spell!.meta.sharing, outOfSync: false),
        ),
      );
      setFromEntity(spell!);
    }
    createInputs();
  }

  @override
  final entity = Spell.empty().obs;

  Spell setFromEntity(Spell spell) => setData({
        'name': spell.name,
        'description': spell.description,
        'explanation': spell.explanation,
        'tags': spell.tags,
        'dice': spell.dice,
        'classKeys': spell.classKeys,
      });

  @override
  Spell setData(Map<String, dynamic> data) {
    entity.value = entity.value.copyWithInherited(
      meta: entity.value.meta.copyWith(
        sharing: MetaSharing.createFork(spell!.key, spell!.meta.sharing, outOfSync: true),
      ),
      name: data['name'],
      description: data['description'],
      explanation: data['explanation'],
      tags: data['tags'],
      dice: data['dice'],
      classKeys: asList(data['classKeys']),
    );

    return entity.value;
  }

  void createInputs() {
    inputs = <FormInputData>[
      FormInputData<FormTextInputData>(
        name: 'name',
        // TODO intl + hint text
        data: FormTextInputData(
          label: 'Spell name',
          textCapitalization: TextCapitalization.words,
          text: entity.value.name,
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
        // TODO intl + hint text
        data: FormTextInputData(
          label: 'Spell description',
          maxLines: 10,
          minLines: 5,
          rich: true,
          textCapitalization: TextCapitalization.sentences,
          text: entity.value.description,
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'explanation',
        // TODO intl + hint text
        data: FormTextInputData(
          label: 'Spell explanation',
          maxLines: 10,
          minLines: 5,
          rich: true,
          textCapitalization: TextCapitalization.sentences,
          text: entity.value.explanation,
        ),
      ),
      FormInputData<FormDiceInputData>(
        name: 'dice',
        data: FormDiceInputData(
          value: entity.value.dice,
          rollStats: rollStats,
          guessFrom: {'description', 'explanation'},
        ),
      ),
      FormInputData<FormTagsInputData>(
        name: 'tags',
        data: FormTagsInputData(value: entity.value.tags),
      ),
    ];
  }
}
