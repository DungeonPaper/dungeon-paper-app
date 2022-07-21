import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class SpellForm extends GetView<DynamicFormController<Spell>> {
  const SpellForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicForm<Spell>(
      entity: controller.entity.value,
      inputs: controller.inputs,
      onChange: (d) => controller.setData(d, setDirty: true),
      onReplace: (d) => controller.setFromEntity(d),
    );
  }
}

class SpellFormController extends DynamicFormController<Spell> {
  late AbilityScores abilityScores;

  @override
  final entity = Spell.empty().obs;

  @override
  void onInit() {
    final SpellFormArguments args = Get.arguments;
    if (args.entity != null) {
      entity.value = args.entity!;
    }
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
      }, setDirty: false);

  @override
  Spell setData(Map<String, dynamic> data, {required bool setDirty}) {
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
          label: S.current.formGeneralNameGeneric(S.current.entity(Spell)),
          textCapitalization: TextCapitalization.words,
          text: entity.value.name,
        ),
      ),
      FormInputData(
        name: 'classKeys',
        data: FormDropdownInputData(
          value: entity.value.classKeys.isNotEmpty ? entity.value.classKeys[0] : null,
          isExpanded: true,
          compareTo: (a, b) => a?.key == b?.key,
          label: Text(S.current.entity(Spell)),
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
          label: S.current.formGeneralDescriptionGeneric(S.current.entity(Spell)),
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
          label: S.current.formGeneralExplanationGeneric(S.current.entity(Spell)),
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

class SpellFormArguments extends LibraryEntityFormArguments<Spell> {
  final AbilityScores abilityScores;
  // final List<dw.EntityReference> classKeys;

  SpellFormArguments({
    required super.entity,
    required super.onSave,
    required super.type,
    required this.abilityScores,
    // required this.classKeys,
  });
}
