import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
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
              PopupMenuButton<String>(
                itemBuilder: (ctx) => items,
                onSelected: (value) => _handleMenu(value),
                icon: Stack(children: [
                  const Icon(Icons.more_vert),
                  if (data.meta.sharing?.dirty == true)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange[400],
                        ),
                      ),
                    ),
                ]),
              ),
            ],
          ),
          body: buildForm(context),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: DwColors.success,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              onSave(data);
              Get.back();
            },
            label: Text(S.current.save),
            icon: const Icon(Icons.save),
          ),
        ),
      ),
    );
  }

  final items = const <PopupMenuItem<String>>[
    PopupMenuItem(
      // TODO intl
      child: Text('Update original'),
      value: 'push',
    ),
    PopupMenuItem(
      // TODO intl
      child: Text('Revert changes'),
      value: 'pull',
    ),
  ];

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

  _handleMenu(String? value) {
    final curItem = data;

    switch (value) {
      case 'push':
        debugPrint('Update original');
        break;
      case 'pull':
        debugPrint('Revert changes');
        break;
      default:
        throw UnsupportedError('Bad menu item value: $value');
    }
  }
}
