import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/widgets/forms/add_move_form.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class RepositoryItemForm<T> extends StatefulWidget {
  const RepositoryItemForm({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final void Function(T item) onSave;

  @override
  State<RepositoryItemForm<T>> createState() => _RepositoryItemFormState<T>();
}

class _RepositoryItemFormState<T> extends State<RepositoryItemForm<T>> {
  late T data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        actions: [
          ElevatedButton(
            onPressed: () => widget.onSave(data),
            child: Text(S.current.saveGeneric(S.current.entity(T))),
          )
        ],
      ),
      body: buildForm(context),
    );
  }

  Widget get title => Text(S.current.addGeneric(S.current.entity(T)));

  void setEntity(dynamic item) {
    setState(() {
      data = item as T;
    });
  }

  Widget buildForm(BuildContext context) {
    switch (T) {
      case Move:
        return AddMoveForm(onChange: setEntity);
      default:
        throw UnsupportedError('Unsupported type: $T');
    }
  }
}
