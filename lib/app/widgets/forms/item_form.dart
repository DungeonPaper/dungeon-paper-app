import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/molecules/tag_list_input.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemForm extends GetView<ItemFormController> {
  const ItemForm({super.key});

  @override
  Widget build(BuildContext context) {
    return LibraryEntityForm<Item, ItemFormController>(
      children: [
        () => Obx(
              () => TextFormField(
                controller: controller.name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  label: Text(tr.generic.entityName(tr.entity(Item))),
                ),
              ),
            ),
        () => Obx(
              () => RichTextField(
                controller: controller.description,
                label: tr.generic.entityDescription(tr.entity(Item)),
                maxLines: 10,
                minLines: 5,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
        () => Obx(
              () => TagListInput(
                controller: controller.tags,
              ),
            ),
      ],
    );
  }
}

class ItemFormController
    extends LibraryEntityFormController<Item, ItemFormArgumentsNew> {
  final _name = TextEditingController().obs;
  final _description = TextEditingController().obs;
  final _tags = ValueNotifier<List<dw.Tag>>([]).obs;

  @override
  List<Rx<ValueNotifier>> get fields => [_name, _description, _tags];

  TextEditingController get name => _name.value;
  TextEditingController get description => _description.value;
  ValueNotifier<List<dw.Tag>> get tags => _tags.value;

  @override
  void onInit() {
    super.onInit();
    name.text = args.entity?.name ?? '';
    description.text = args.entity?.description ?? '';
    tags.value = args.entity?.tags ?? [];
  }

  @override
  void updateFromEntity(Item entity) {
    super.updateFromEntity(entity);
    name.text = entity.name;
    description.text = entity.description;
    tags.value = entity.tags;
  }

  @override
  empty() => Item.empty();

  @override
  Item toEntity() => super.toEntity().copyWithInherited(
        name: name.text,
        description: description.text,
        tags: tags.value,
      );
}

class ItemFormArgumentsNew extends LibraryEntityFormArguments<Item> {
  ItemFormArgumentsNew({
    required super.entity,
    required super.onSave,
    required super.formContext,
  });
}
