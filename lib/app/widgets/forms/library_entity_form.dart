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

enum ItemFormType {
  edit,
  create,
}

class LibraryEntityForm<T extends WithMeta> extends GetView<DynamicFormController<T>> {
  const LibraryEntityForm({
    Key? key,
    required this.onSave,
    required this.type,
  }) : super(key: key);

  final void Function(T item) onSave;
  final ItemFormType type;
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
              onSave(entity);
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
        type == ItemFormType.create
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
        return MoveForm(
          onChange: setEntity,
          type: type,
        );
      case Spell:
        return SpellForm(
          onChange: setEntity,
          type: type,
        );
      case Item:
        return ItemForm(
          onChange: setEntity,
          type: type,
        );
      case Note:
        return NoteForm(
          onChange: setEntity,
          type: type,
        );
      case CharacterClass:
        return AddCharacterClassForm(
          onChange: setEntity,
          type: type,
        );
      case Race:
        return RaceForm(
          onChange: setEntity,
          type: type,
        );
      default:
        throw UnsupportedError('Unsupported type: $T');
    }
  }
}
