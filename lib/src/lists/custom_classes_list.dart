import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/atoms/card_list_item.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:flutter/material.dart';

class CustomClassesList extends StatelessWidget {
  final SingleChildWidgetBuilder builder;

  const CustomClassesList({
    Key key,
  })  : builder = null,
        super(key: key);

  const CustomClassesList.builder({
    Key key,
    this.builder,
  }) : super(key: key);

  SingleChildWidgetBuilder get _builder => builder ?? (ctx, child) => child;

  @override
  Widget build(BuildContext context) {
    var child = DWStoreConnector<List<CustomClass>>(
      converter: (store) =>
          store.state.customClasses.customClasses.values.toList(),
      builder: (context, classes) => SingleChildScrollView(
        child: Column(
          children: [
            for (var cls in classes)
              CardListItem(
                title: Text(cls.name),
              )
          ],
        ),
      ),
    );
    return _builder(context, child);
  }
}
