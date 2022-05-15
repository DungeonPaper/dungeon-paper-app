import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteForm extends GetView<DynamicFormController<Note>> {
  const NoteForm({
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

class NoteFormController extends DynamicFormController<Note> {
  NoteFormController({required this.note});

  final Note? note;
  @override
  Note? get argument => note;

  @override
  final entity = Note.empty().obs;

  @override
  Note setFromEntity(Note note) => setData({
        'title': note.title,
        'description': note.description,
        'category': note.category,
        'tags': note.tags,
      });

  @override
  Note setData(Map<String, dynamic> data) {
    entity.value = entity.value.copyWith(
      meta: entity.value.meta,
      title: data['title'],
      description: data['description'],
      category: data['category'],
      tags: data['tags'],
    );

    return entity.value;
  }

  @override
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
          hintText: S.current.noteNoCategory,
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
