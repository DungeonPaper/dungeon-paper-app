import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class RaceForm extends GetView<DynamicFormController<Race>> {
  const RaceForm({
    Key? key,
    required this.onChange,
    required this.type,
  }) : super(key: key);

  final void Function(Race race) onChange;
  final ItemFormType type;

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      entity: controller.entity.value,
      inputs: controller.inputs,
      onChange: (d) => onChange(controller.setData(d, setDirty: true)),
      onReplace: (d) => onChange(controller.setFromEntity(d)),
      builder: (context, inputs, entity) {
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

class RaceFormController extends DynamicFormController<Race> {
  late final Race? race;
  late final AbilityScores abilityScores;

  @override
  Race? get argument => race;

  @override
  final entity = Race.empty().obs;

  @override
  Race setFromEntity(Race race) => setData({
        'name': race.name,
        'description': race.description,
        'explanation': race.explanation,
        'tags': race.tags,
        'dice': race.dice,
        'classKeys': race.classKeys,
      }, setDirty: false);

  @override
  void onInit() {
    final RaceFormArguments args = Get.arguments;
    race = args.race;
    abilityScores = args.abilityScores;
    super.onInit();
  }

  @override
  Race setData(Map<String, dynamic> data, {required bool setDirty}) {
    final classKeysList = asList<dw.EntityReference>(data['classKeys']);
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
    }, setDirty: setDirty);
  }

  @override
  void createInputs() {
    inputs = <FormInputData>[
      FormInputData<FormTextInputData>(
        name: 'name',
        data: FormTextInputData(
          label: S.current.formGeneralNameGeneric(S.current.entity(Race)),
          textCapitalization: TextCapitalization.words,
          text: entity.value.name,
        ),
      ),
      FormInputData(
        name: 'classKeys',
        data: FormDropdownInputData(
          value: entity.value.classKeys.isNotEmpty ? entity.value.classKeys[0] : null,
          isExpanded: true,
          compareTo: (a, b) => a.toString() == b.toString(),
          label: Text(S.current.entity(CharacterClass)),
          items: {...repo.builtIn.classes.values, ...repo.my.classes.values}.map(
            (cls) => DropdownMenuItem(
              child: Text(cls.name),
              value: cls.reference,
            ),
          ),
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'description',
        data: FormTextInputData(
          label: S.current.formGeneralDescriptionGeneric(S.current.entity(Race)),
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
          label: S.current.formGeneralExplanationGeneric(S.current.entity(Race)),
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

class RaceFormArguments {
  final Race? race;
  final AbilityScores abilityScores;

  RaceFormArguments({
    required this.race,
    required this.abilityScores,
  });
}
