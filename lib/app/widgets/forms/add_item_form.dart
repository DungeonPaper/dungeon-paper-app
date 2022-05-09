import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/model_utils/model_meta.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/repository_item_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemForm extends GetView<DynamicFormController<Item>> {
  const AddItemForm({
    Key? key,
    required this.onChange,
    required this.type,
  }) : super(key: key);

  final void Function(Item item) onChange;
  final ItemFormType type;

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      inputs: controller.inputs,
      onChange: (d) => onChange(controller.setData(d)),
    );
  }
}

class AddItemFormController extends DynamicFormController<Item> {
  AddItemFormController({required this.item});

  final Item? item;

  @override
  void init() {
    if (item != null) {
      entity.value = item!.copyWithInherited(
        meta: item!.meta.copyWith(
          sharing: MetaSharing.createFork(item!.key, meta: item!.meta.sharing, dirty: false),
        ),
      );
      setFromEntity(item!);
    }
    createInputs();
  }

  @override
  final entity = Item.empty().obs;

  Item setFromEntity(Item item) => setData({
        'name': item.name,
        'description': item.description,
        'tags': item.tags,
      });

  @override
  Item setData(Map<String, dynamic> data) {
    entity.value = entity.value.copyWithInherited(
      meta: entity.value.meta,
      name: data['name'],
      description: data['description'],
      tags: data['tags'],
    );

    return entity.value;
  }

  void createInputs() {
    inputs = <FormInputData>[
      FormInputData<FormTextInputData>(
        name: 'name',
        // TODO intl + hint text
        data: FormTextInputData(
          label: 'Item name',
          textCapitalization: TextCapitalization.words,
          text: entity.value.name,
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'description',
        // TODO intl + hint text
        data: FormTextInputData(
          label: 'Item description',
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
