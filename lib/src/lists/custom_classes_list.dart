import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/atoms/card_list_item.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:flutter/material.dart';

class CustomClassesList extends StatelessWidget {
  final SingleChildWidgetBuilder builder;
  final void Function(CustomClass) onEdit;
  final void Function(CustomClass) onDelete;

  const CustomClassesList({
    Key key,
    this.onEdit,
    this.onDelete,
  })  : builder = null,
        super(key: key);

  const CustomClassesList.builder({
    Key key,
    this.builder,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  SingleChildWidgetBuilder get _builder => builder ?? (ctx, child) => child;

  @override
  Widget build(BuildContext context) {
    var child = DWStoreConnector<List<CustomClass>>(
      converter: (store) =>
          store.state.customClasses.customClasses.values.toList(),
      builder: (context, classes) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var cls in classes)
              InkWell(
                onTap: onEdit != null ? () => onEdit(cls) : null,
                child: CardListItem(
                  leading: Icon(Icons.person, size: 40),
                  title: Text(cls.name),
                ),
              )
          ],
        ),
      ),
    );
    return _builder(context, child);
  }
}
