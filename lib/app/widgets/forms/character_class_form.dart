import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCharacterClassForm extends GetView<DynamicFormController<CharacterClass>> {
  const AddCharacterClassForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicForm<CharacterClass>(
      entity: controller.entity.value,
      inputs: controller.inputs,
      onChange: (d) => controller.setData(d, setDirty: true),
      onReplace: (d) => controller.setFromEntity(d),
      builder: (context, inputs, WithMeta entity) => ListView(
        children: [
          ...inputs.sublist(0, inputs.length - 4).map(_pad),
          Row(
            children: enumerate(inputs.sublist(inputs.length - 4, inputs.length - 2))
                .map(
                  (e) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(
                        left: e.isFirst ? 16 : null,
                        right: e.isLast ? 16 : null,
                      ),
                      child: e.value,
                    ),
                  ),
                )
                .toList(),
          ),
          ...inputs.sublist(inputs.length - 2, inputs.length).map(_pad),
        ],
      ),
    );
  }

  Widget _pad(Widget child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: child,
      );
}

class CharacterClassFormController extends DynamicFormController<CharacterClass> {
  @override
  final entity = CharacterClass.empty().obs;

  @override
  void onInit() {
    final CharacterClassFormArguments args = Get.arguments;
    if (args.entity != null) {
      entity.value = args.entity!;
    }
    super.onInit();
  }

  @override
  CharacterClass setFromEntity(CharacterClass characterClass) => setData({
        'name': characterClass.name,
        'description': characterClass.description,
        'damageDice': characterClass.damageDice,
        'hp': characterClass.hp,
        'load': characterClass.load,
      }, setDirty: false);

  @override
  CharacterClass setData(Map<String, dynamic> data, {required bool setDirty}) {
    entity.value = entity.value.copyWithInherited(
      meta: data['meta'] ?? entity.value.meta,
      name: data['name'],
      description: data['description'],
      damageDice: asList(data['damageDice']).first,
      hp: int.tryParse(data['hp']?.toString() ?? ''),
      load: int.tryParse(data['load']?.toString() ?? ''),
    );

    return super.setData({
      ...data,
      'damageDice': asList<dw.Dice>(data['damageDice']),
    }, setDirty: setDirty);
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
        name: 'damageDice',
        data: FormDiceInputData(
          label: Text(S.current.formCharacterClassDamage),
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
      ),
      FormInputData<FormNumberInputData>(
        name: 'hp',
        data: FormNumberInputData(
          numberType: NumberType.int,
          label: S.current.formCharacterClassBaseHp,
          text: entity.value.hp.toString(),
        ),
      ),
      FormInputData<FormNumberInputData>(
        name: 'load',
        data: FormNumberInputData(
          numberType: NumberType.int,
          label: S.current.formCharacterClassBaseLoad,
          text: entity.value.load.toString(),
        ),
      ),
    ];
  }
}

class CharacterClassFormArguments extends LibraryEntityFormArguments<CharacterClass> {
  CharacterClassFormArguments({
    required super.entity,
    required super.onSave,
    required super.type,
  });
}
