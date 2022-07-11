import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpellForm extends GetView<DynamicFormController<Spell>> {
  const SpellForm({
    Key? key,
    required this.onChange,
    required this.type,
  }) : super(key: key);

  final void Function(Spell spell) onChange;
  final ItemFormType type;

  @override
  Widget build(BuildContext context) {
    return DynamicForm<Spell>(
      entity: controller.entity.value,
      inputs: controller.inputs,
      onChange: (d) => onChange(controller.setData(d)),
      onReplace: (d) => onChange(controller.setFromEntity(d)),
    );
  }
}

class SpellFormController extends DynamicFormController<Spell> {
  late final Spell? spell;
  late final AbilityScores abilityScores;

  @override
  Spell? get argument => spell;

  @override
  final entity = Spell.empty().obs;

  @override
  void onInit() {
    final SpellFormArguments args = Get.arguments;
    spell = args.spell;
    abilityScores = args.abilityScores;
    super.onInit();
  }

  @override
  Spell setFromEntity(Spell spell) => setData({
        'meta': spell.meta,
        'name': spell.name,
        'description': spell.description,
        'explanation': spell.explanation,
        'tags': spell.tags,
        'dice': spell.dice,
        'classKeys': spell.classKeys,
      });

  @override
  Spell setData(Map<String, dynamic> data) {
    final classKeysList = asList<String>(data['classKeys']);
    entity.value = entity.value.copyWithInherited(
      meta: data['meta'] ?? entity.value.meta,
      name: data['name'],
      description: data['description'],
      explanation: data['explanation'],
      tags: data['tags'],
      dice: data['dice'],
      classKeys: classKeysList,
    );

    return super.setData({
      ...data,
      'classKeys': classKeysList.isEmpty ? null : classKeysList[0],
    });
  }

  @override
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
          compareTo: (a, b) => a.toString() == b.toString(),
          // TODO intl
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
          abilityScores: abilityScores,
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

class SpellFormArguments {
  final Spell? spell;
  final AbilityScores abilityScores;
  // final List<String> classKeys;

  SpellFormArguments({
    required this.spell,
    required this.abilityScores,
    // required this.classKeys,
  });
}
