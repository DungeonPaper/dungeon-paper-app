import 'package:flutter/material.dart';

class CardBottomControls extends StatelessWidget {
  final String entityTypeName;
  final List<Widget> leading;
  final List<Widget> trailing;
  final Function onEdit;
  final Function onDelete;

  const CardBottomControls({
    Key key,
    this.onEdit,
    this.onDelete,
    this.entityTypeName,
    this.leading = const [],
    this.trailing = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buttons = getButtons();
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: buttons);
  }

  List<Widget> getButtons() {
    var buttons = <Widget>[];
    Widget editButton = IconButton(
      tooltip: suffixType('Edit'),
      icon: Icon(Icons.edit),
      onPressed: onEdit,
    );
    Widget deleteButton = IconButton(
      tooltip: suffixType('Delete'),
      icon: Icon(Icons.delete),
      onPressed: onDelete,
    );
    if (leading.isNotEmpty) {
      buttons.addAll(leading);
    }
    if (onEdit != null) {
      buttons.add(editButton);
    }
    if (onDelete != null) {
      buttons.add(deleteButton);
    }
    if (trailing.isNotEmpty) {
      buttons.addAll(trailing);
    }
    return buttons;
  }

  String suffixType(String text) {
    if (entityTypeName != null) {
      return '$text $entityTypeName';
    }

    return text;
  }
}
