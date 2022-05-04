import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/repository_item_form.dart';
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
    return DynamicForm(
      inputs: controller.inputs,
      onChange: (d) => onChange(controller.setData(d)),
    );
  }
}

class AddCharacterClassFormController extends DynamicFormController<CharacterClass> {
  AddCharacterClassFormController({required this.characterClass});

  final CharacterClass? characterClass;

  @override
  void init() {
    if (characterClass != null) {
      entity.value = characterClass!.copyWithInherited(
        meta: characterClass!.meta.copyWith(
          sharing: MetaSharing.createFork(characterClass!.key,
              meta: characterClass!.meta.sharing, dirty: false),
        ),
      );
      setFromEntity(characterClass!);
    }
    createInputs();
  }

  @override
  final entity = CharacterClass.empty().obs;

  CharacterClass setFromEntity(CharacterClass characterClass) => setData({
        'name': characterClass.name,
        'description': characterClass.description,
      });

  @override
  CharacterClass setData(Map<String, dynamic> data) {
    entity.value = entity.value.copyWithInherited(
      meta: entity.value.meta.copyWith(
        sharing:
            MetaSharing.createFork(entity.value.key, meta: entity.value.meta.sharing, dirty: true),
      ),
      name: data['name'],
      description: data['description'],
    );

    return entity.value;
  }

  void createInputs() {
    inputs = <FormInputData>[
      FormInputData<FormTextInputData>(
        name: 'name',
        // TODO intl + hint text
        data: FormTextInputData(
          label: 'Name',
          textCapitalization: TextCapitalization.words,
          text: entity.value.name,
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'description',
        // TODO intl + hint text
        data: FormTextInputData(
          label: 'Description',
          maxLines: 20,
          minLines: 5,
          rich: true,
          textCapitalization: TextCapitalization.sentences,
          text: entity.value.description,
        ),
      ),
    ];
  }
}
