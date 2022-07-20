import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/forms/item_form.dart';
import 'package:dungeon_paper/app/widgets/forms/move_form.dart';
import 'package:dungeon_paper/app/widgets/forms/note_form.dart';
import 'package:dungeon_paper/app/widgets/forms/race_form.dart';
import 'package:dungeon_paper/app/widgets/forms/spell_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'character_class_form.dart';

enum FormContext {
  edit,
  create,
}

class LibraryEntityForm<T extends WithMeta> extends GetView<DynamicFormController<T>> {
  const LibraryEntityForm({Key? key}) : super(key: key);

  T get entity => controller.entity.value;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            title: title,
          ),
          body: buildForm(context, entity),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: () {
              controller.onChange(entity);
              Get.back();
            },
            label: Text(S.current.save),
            icon: const Icon(Icons.save),
          ),
        ),
      ),
    );
  }

  User get user => Get.find<UserService>().current;

  Widget get title => Text(
        controller.type == FormContext.create
            ? S.current.addGeneric(S.current.entity(T))
            : S.current.editGeneric(S.current.entity(T)),
      );

  void setEntity(dynamic item) {
    controller.entity.value = item as T;
    controller.dirty.value = true;
  }

  Widget buildForm(BuildContext context, T entity) {
    switch (T) {
      case Move:
        return const MoveForm();
      case Spell:
        return const SpellForm();
      case Item:
        return const ItemForm();
      case Note:
        return const NoteForm();
      case CharacterClass:
        return const AddCharacterClassForm();
      case Race:
        return const RaceForm();
      default:
        throw UnsupportedError('Unsupported type: $T');
    }
  }
}

class LibraryEntityFormArguments<T extends WithMeta> {
  final void Function(T item) onChange;
  final FormContext type;
  final T? entity;

  LibraryEntityFormArguments({
    required this.entity,
    required this.onChange,
    required this.type,
  });
}
