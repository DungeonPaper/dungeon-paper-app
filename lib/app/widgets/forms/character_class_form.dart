import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCharacterClassForm extends GetView<DynamicFormController<CharacterClass>> {
  const AddCharacterClassForm({
    Key? key,
    required this.onChange,
    required this.type,
  }) : super(key: key);

  final void Function(CharacterClass characterClass) onChange;
  final ItemFormType type;

  @override
  Widget build(BuildContext context) {
    return DynamicForm<CharacterClass>(
      entity: controller.entity.value,
      inputs: controller.inputs,
      onChange: (d) => onChange(controller.setData(d)),
      onReplace: (d) => onChange(controller.setFromEntity(d)),
    );
  }
}

class CharacterClassFormController extends DynamicFormController<CharacterClass> {
  late final CharacterClass? characterClass;

  @override
  CharacterClass? get argument => characterClass;

  @override
  final entity = CharacterClass.empty().obs;

  @override
  void onInit() {
    final CharacterClassFormArguments args = Get.arguments;
    characterClass = args.characterClass;
    super.onInit();
  }

  @override
  CharacterClass setFromEntity(CharacterClass characterClass) => setData({
        'name': characterClass.name,
        'description': characterClass.description,
      });

  @override
  CharacterClass setData(Map<String, dynamic> data) {
    entity.value = entity.value.copyWithInherited(
      meta: entity.value.meta,
      name: data['name'],
      description: data['description'],
    );

    return entity.value;
  }

  @override
  void createInputs() {
    inputs = <FormInputData>[
      FormInputData<FormTextInputData>(
        name: 'name',
        data: FormTextInputData(
          label: S.current.formGeneralName,
          textCapitalization: TextCapitalization.words,
          text: entity.value.name,
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'description',
        data: FormTextInputData(
          label: S.current.formGeneralDescription,
          hintText: S.current.formCharacterClassDescriptionPlaceholder,
          maxLines: 20,
          minLines: 5,
          rich: true,
          textCapitalization: TextCapitalization.sentences,
          text: entity.value.description,
        ),
      ),
      FormInputData(
        name: 'damage',
        data: FormDiceInputData(
          abilityScores: AbilityScores.dungeonWorld(
            cha: 12,
            con: 12,
            dex: 12,
            str: 12,
            wis: 12,
            intl: 12,
          ),
          guessFrom: {},
          value: [entity.value.damageDice],
          maxCount: 1,
        ),
      )
    ];
  }
}

class CharacterClassFormArguments {
  final CharacterClass? characterClass;

  CharacterClassFormArguments({
    required this.characterClass,
  });
}
