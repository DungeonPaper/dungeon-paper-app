import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/molecules/tag_list_input.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteForm extends GetView<NoteFormController> with RepositoryServiceMixin {
  const NoteForm({super.key});

  @override
  Widget build(BuildContext context) {
    return LibraryEntityForm<Note, NoteFormController>(
      children: [
        () => Obx(
              () => TextFormField(
                decoration: InputDecoration(
                  label: Text(
                    tr.generic.entityName(tr.entity(tn(Note))),
                  ),
                ),
                textCapitalization: TextCapitalization.words,
                controller: controller.title,
              ),
            ),
        () => Obx(
              () => RichTextField(
                decoration: InputDecoration(
                  label: Text(
                    tr.generic.entityDescription(tr.entity(tn(Note))),
                  ),
                ),
                maxLines: 10,
                minLines: 5,
                rich: true,
                textCapitalization: TextCapitalization.sentences,
                controller: controller.description,
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

class NoteFormController
    extends LibraryEntityFormController<Note, NoteFormArguments> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _category = TextEditingController();
  final _dice = ValueNotifier<List<dw.Dice>>([]);
  final _tags = ValueNotifier<List<dw.Tag>>([]);

  TextEditingController get title => _title;
  TextEditingController get description => _description;
  TextEditingController get category => _category;
  ValueNotifier<List<dw.Tag>> get tags => _tags;

  @override
  List<ValueNotifier> get fields =>
      [_title, _description, _category, _dice, _tags];

NoteFormController(super.context) {
    debugPrint('NoteFormController onInit, ${args.entity?.description ?? ''}');
    title.text = args.entity?.title ?? '';
    description.text = args.entity?.description ?? '';
    tags.value = args.entity?.tags ?? [];
    category.text = args.entity?.category ?? '';
  }

  @override
  void updateFromEntity(Note entity) {
    debugPrint('NoteFormController updateFromEntity, ${entity.description}');
    super.updateFromEntity(entity);
    title.text = entity.title;
    description.text = entity.description;
    tags.value = entity.tags;
    category.text = entity.category;
  }

  @override
  Note toEntity() => super.toEntity().copyWithInherited(
        title: title.text,
        description: description.text,
        tags: tags.value,
        category: category.text,
      );

  @override
  Note empty() => Note.empty();
}

class NoteFormArguments extends LibraryEntityFormArguments<Note> {
  NoteFormArguments({
    required super.entity,
    required super.onSave,
    required super.formContext,
  });
}
