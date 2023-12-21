import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/molecules/tag_list_input.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemForm extends StatelessWidget {
  const ItemForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemFormController>(
      builder: (context, controller, _) =>
          LibraryEntityForm<Item, ItemFormController>(
        children: [
          () => TextFormField(
                controller: controller.name,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  label: Text(tr.generic.entityName(tr.entity(tn(Item)))),
                ),
              ),
          () => RichTextField(
                controller: controller.description,
                label: tr.generic.entityDescription(tr.entity(tn(Item))),
                maxLines: 10,
                minLines: 5,
                textCapitalization: TextCapitalization.sentences,
              ),
          () => TagListInput(
                controller: controller.tags,
              ),
        ],
      ),
    );
  }
}

class ItemFormController
    extends LibraryEntityFormController<Item, ItemFormArgumentsNew> {
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _tags = ValueNotifier<List<dw.Tag>>([]);

  @override
  List<ValueNotifier> get fields => [_name, _description, _tags];

  TextEditingController get name => _name;
  TextEditingController get description => _description;
  ValueNotifier<List<dw.Tag>> get tags => _tags;

  ItemFormController(super.context) {
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
