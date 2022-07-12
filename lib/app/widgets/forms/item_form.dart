import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemForm extends GetView<DynamicFormController<Item>> {
  const ItemForm({
    Key? key,
    required this.onChange,
    required this.type,
  }) : super(key: key);

  final void Function(Item item) onChange;
  final ItemFormType type;

  @override
  Widget build(BuildContext context) {
    return DynamicForm<Item>(
      entity: controller.entity.value,
      inputs: controller.inputs,
      onChange: (d) => onChange(controller.setData(d)),
      onReplace: (d) => onChange(controller.setFromEntity(d)),
    );
  }
}

class ItemFormController extends DynamicFormController<Item> {
  late final Item? item;

  @override
  Item? get argument => item;

  @override
  final entity = Item.empty().obs;

  @override
  void onInit() {
    final ItemFormArguments args = Get.arguments;
    item = args.item;
    super.onInit();
  }

  @override
  Item setFromEntity(Item item) => setData({
        'name': item.name,
        'description': item.description,
        'tags': item.tags,
      });

  @override
  Item setData(Map<String, dynamic> data) {
    entity.value = entity.value.copyWithInherited(
      meta: data['meta'] ?? entity.value.meta,
      name: data['name'],
      description: data['description'],
      tags: data['tags'],
    );

    return super.setData(data);
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

class ItemFormArguments {
  final Item? item;

  ItemFormArguments({
    required this.item,
  });
}
