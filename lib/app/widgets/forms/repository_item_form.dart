import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/widgets/forms/add_move_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class RepositoryItemForm<T> extends StatelessWidget {
  const RepositoryItemForm({
    Key? key,
    required this.onSave,
  }) : super(key: key);

  final void Function(T item) onSave;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: buildForm(context),
    );
  }

  Widget get title => Text(S.current.addGeneric(S.current.entity(T)));

  Widget buildForm(BuildContext context) {
    switch (T) {
      case Move:
        return AddMoveForm(onChange: (move) => debugPrint('Updated: $move'));
      default:
        throw UnsupportedError('Unsupported type: $T');
    }
  }
}
