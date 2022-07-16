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
    return DynamicForm<Note>(
      entity: controller.entity.value,
      inputs: controller.inputs,
      onChange: (d) => onChange(controller.setData(d, setDirty: true)),
      onReplace: (d) => onChange(controller.setFromEntity(d)),
    );
  }
}

class NoteFormController extends DynamicFormController<Note> {
  late final Note? note;
  @override
  Note? get argument => note;

  @override
  final entity = Note.empty().obs;

  @override
  void onInit() {
    final NoteFormArguments args = Get.arguments;
    note = args.note;
    super.onInit();
  }

  @override
  Note setFromEntity(Note note) => setData({
        'title': note.title,
        'description': note.description,
        'category': note.category,
        'tags': note.tags,
      }, setDirty: false);

  @override
  Note setData(Map<String, dynamic> data, {required bool setDirty}) {
    entity.value = entity.value.copyWith(
      meta: data['meta'] ?? entity.value.meta,
      title: data['title'],
      description: data['description'],
      category: data['category'],
      tags: data['tags'],
    );

    return super.setData(data, setDirty: setDirty);
  }

  @override
  void createInputs() {
    inputs = <FormInputData>[
      FormInputData<FormTextInputData>(
        name: 'title',
        data: FormTextInputData(
          label: S.current.formGeneralTitleGeneric(S.current.entity(Note)),
          textCapitalization: TextCapitalization.words,
          text: entity.value.title,
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'category',
        data: FormTextInputData(
          label: S.current.formGeneralCategoryGeneric(S.current.entity(Note)),
          textCapitalization: TextCapitalization.words,
          text: entity.value.category,
          hintText: S.current.noteNoCategory,
        ),
      ),
      FormInputData<FormTextInputData>(
        name: 'description',
        data: FormTextInputData(
          label: S.current.formGeneralDescriptionGeneric(S.current.entity(Note)),
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

class NoteFormArguments {
  final Note? note;

  NoteFormArguments({
    required this.note,
  });
}
