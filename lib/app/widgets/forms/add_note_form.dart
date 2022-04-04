import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/repository_item_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNoteForm extends GetView<DynamicFormController<Note>> {
  const AddNoteForm({
    Key? key,
    required this.onChange,
    required this.type,
  }) : super(key: key);

  final void Function(Note note) onChange;
  final ItemFormType type;

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      inputs: controller.inputs,
      onChange: (d) => onChange(controller.setData(d)),
    );
  }
}

class AddNoteFormController extends DynamicFormController<Note> {
  AddNoteFormController({required this.note});

  final Note? note;

  @override
  void init() {
    if (note != null) {
      entity.value = note!.copyWith(
        meta: note!.meta.copyWith(
          sharing: MetaSharing.createFork(note!.key, meta: note!.meta.sharing, dirty: false),
        ),
      );
      setFromEntity(note!);
    }
    createInputs();
  }

  @override
  final entity = Note.empty().obs;

  Note setFromEntity(Note note) => setData({
        'title': note.title,
        'description': note.description,
        'category': note.category,
        'tags': note.tags,
      });

  @override
  Note setData(Map<String, dynamic> data) {
    entity.value = entity.value.copyWith(
      meta: entity.value.meta.copyWith(
        sharing:
            MetaSharing.createFork(entity.value.key, meta: entity.value.meta.sharing, dirty: true),
      ),
      title: data['title'],
      description: data['description'],
      category: data['category'],
      tags: data['tags'],
    );

    return entity.value;
  }

  void createInputs() {
    inputs = <FormInputData>[
      FormInputData<FormTextInputData>(
        name: 'title',
        // TODO intl + hint text
        data: FormTextInputData(
          label: 'Note title',
          textCapitalization: TextCapitalization.words,
          text: entity.value.title,
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'category',
        // TODO intl + hint text
        data: FormTextInputData(
          label: 'Note category',
          textCapitalization: TextCapitalization.words,
          text: entity.value.category,
          hintText: S.current.noCategory,
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'description',
        // TODO intl + hint text
        data: FormTextInputData(
          label: 'Note description',
          maxLines: 20,
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
