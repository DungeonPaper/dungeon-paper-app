import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/model_utils/model_meta.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/meta_sync_menu.dart';
import 'package:dungeon_paper/app/widgets/forms/add_item_form.dart';
import 'package:dungeon_paper/app/widgets/forms/add_move_form.dart';
import 'package:dungeon_paper/app/widgets/forms/add_note_form.dart';
import 'package:dungeon_paper/app/widgets/forms/add_spell_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_character_class_form.dart';

enum ItemFormType {
  edit,
  create,
}

class RepositoryItemForm<T extends WithMeta> extends GetView<DynamicFormController<T>> {
  const RepositoryItemForm({
    Key? key,
    required this.onSave,
    required this.type,
  }) : super(key: key);

  final void Function(T item) onSave;
  final ItemFormType type;
  T get data => controller.entity.value;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            title: title,
            actions: [
              MetaSyncMenu(entity: data),
            ],
          ),
          body: buildForm(context),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: () {
              onSave(increaseMetaVersion(data));
              Get.back();
            },
            label: Text(S.current.save),
            icon: const Icon(Icons.save),
          ),
        ),
      ),
    );
  }

  Widget get title => Text(
        type == ItemFormType.create
            ? S.current.addGeneric(S.current.entity(T))
            : S.current.editGeneric(S.current.entity(T)),
      );

  void setEntity(dynamic item) {
    controller.entity.value = item as T;
    controller.dirty.value = true;
  }

  Widget buildForm(BuildContext context) {
    switch (T) {
      case Move:
        return AddMoveForm(
          onChange: setEntity,
          type: type,
        );
      case Spell:
        return AddSpellForm(
          onChange: setEntity,
          type: type,
        );
      case Item:
        return AddItemForm(onChange: setEntity, type: type);
      case Note:
        return AddNoteForm(onChange: setEntity, type: type);
      case CharacterClass:
        return AddCharacterClassForm(onChange: setEntity, type: type);
      default:
        throw UnsupportedError('Unsupported type: $T');
    }
  }
}
