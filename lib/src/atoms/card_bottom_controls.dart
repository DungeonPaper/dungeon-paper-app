import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    @required this.entityTypeName,
    this.leading = const [],
    this.trailing = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buttons = getButtons(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: buttons,
    );
  }

  List<Widget> getButtons(BuildContext context) {
    var buttons = <Widget>[];
    Widget editButton = IconButton(
      color: Get.theme.colorScheme.secondary,
      tooltip: suffixType('Edit'),
      icon: Icon(Icons.edit),
      onPressed: _addAnalytics('Edit', onEdit),
    );
    Widget deleteButton = IconButton(
      color: Get.theme.colorScheme.secondary,
      tooltip: suffixType('Delete'),
      icon: Icon(Icons.delete),
      onPressed: _addAnalytics('Delete', onDelete),
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

  void Function() _addAnalytics(String actionName, void Function() action) {
    return () {
      final _actionName =
          '${actionName.toLowerCase()}_${camelToSnake(entityTypeName)}';
      logger.d(_actionName);
      analytics.logEvent(name: _actionName);
      action?.call();
    };
  }
}
