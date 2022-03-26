import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/widgets/forms/add_move_form.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ItemFormType {
  edit,
  create,
}

class RepositoryItemForm<T extends WithMeta> extends StatefulWidget {
  const RepositoryItemForm({
    Key? key,
    required this.onSave,
    this.extraData = const {},
    required this.type,
  }) : super(key: key);

  final void Function(T item) onSave;
  final Map<String, dynamic> extraData;
  final ItemFormType type;

  @override
  State<RepositoryItemForm<T>> createState() => _RepositoryItemFormState<T>();
}

class _RepositoryItemFormState<T extends WithMeta> extends State<RepositoryItemForm<T>> {
  T? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (ctx) => items,
            onSelected: (value) => _handleMenu(value),
            icon: Stack(children: [
              const Icon(Icons.more_vert),
              // ignore: unnecessary_null_comparison
              if (data?.meta.sharing?.outOfSync == true)
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
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        onPressed: () {
          widget.onSave(data!);
          Get.back();
        },
        label: Text(S.current.save),
        icon: const Icon(Icons.save),
      ),
    );
  }

  final items = const <PopupMenuItem<String>>[
    PopupMenuItem(
      child: Text('Update original'),
      value: 'push',
    ),
    PopupMenuItem(
      child: Text('Revert changes'),
      value: 'pull',
    ),
  ];

  Widget get title => Text(S.current.addGeneric(S.current.entity(T)));

  void setEntity(dynamic item) {
    setState(() {
      data = item as T;
    });
  }

  Widget buildForm(BuildContext context) {
    switch (T) {
      case Move:
        return AddMoveForm(onChange: setEntity, classKey: widget.extraData['classKey'] ?? '');
      default:
        throw UnsupportedError('Unsupported type: $T');
    }
  }

  _handleMenu(String? value) {
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
