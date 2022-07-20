import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemForm extends GetView<DynamicFormController<Item>> {
  const ItemForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicForm<Item>(
      entity: controller.entity.value,
      inputs: controller.inputs,
      onChange: (d) => controller.onChange(controller.setData(d, setDirty: true)),
      onReplace: (d) => controller.onChange(controller.setFromEntity(d)),
    );
  }
}

class ItemFormController extends DynamicFormController<Item> {
  @override
  final entity = Item.empty().obs;

  @override
  void onInit() {
    final ItemFormArguments args = Get.arguments;
    if (args.entity != null) {
      entity.value = args.entity!;
    }
    super.onInit();
  }

  @override
  Item setFromEntity(Item item) => setData({
        'name': item.name,
        'description': item.description,
        'tags': item.tags,
      }, setDirty: false);

  @override
  Item setData(Map<String, dynamic> data, {required bool setDirty}) {
    entity.value = entity.value.copyWithInherited(
      meta: data['meta'] ?? entity.value.meta,
      name: data['name'],
      description: data['description'],
      tags: data['tags'],
    );

    return super.setData(data, setDirty: setDirty);
  }

  @override
  void createInputs() {
    inputs = <FormInputData>[
      FormInputData<FormTextInputData>(
        name: 'name',
        data: FormTextInputData(
          label: S.current.formGeneralNameGeneric(S.current.entity(Item)),
          textCapitalization: TextCapitalization.words,
          text: entity.value.name,
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'description',
        data: FormTextInputData(
          label: S.current.formGeneralDescriptionGeneric(S.current.entity(Item)),
          maxLines: 10,
          minLines: 5,
          rich: true,
          textCapitalization: TextCapitalization.sentences,
          text: entity.value.description,
        ),
      ),
      FormInputData<FormTagsInputData>(
        name: 'tags',
        data: FormTagsInputData(value: entity.value.tags),
      ),
    ];
  }
}

class ItemFormArguments extends LibraryEntityFormArguments<Item> {
  ItemFormArguments({
    required super.entity,
    required super.onChange,
    required super.type,
  });
}
