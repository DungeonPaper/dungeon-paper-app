import 'package:flutter/material.dart';

class CardBottomControls extends StatelessWidget {
  final String entityTypeName;
  final Function onEdit;
  final Function onDelete;

  const CardBottomControls({
    Key key,
    this.onEdit,
    this.onDelete,
    this.entityTypeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [];
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
    if (onEdit != null) {
      buttons.add(editButton);
    }
    if (onDelete != null) {
      buttons.add(deleteButton);
    }
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: buttons);
  }

  String suffixType(String text) {
    if (entityTypeName != null) {
      return '$text $entityTypeName';
    }

    return text;
  }
}
