import 'package:dungeon_paper/main_view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

typedef E BuilderAnyFunction<T, E>(T category, num index);
typedef Widget BuilderFunction<T>(BuildContext context, T category, num index);

class CategorizedList<T> extends StatelessWidget {
  final Iterable<T> categories;
  final BuilderFunction<T> itemBuilder;
  final BuilderFunction<T> titleBuilder;
  final BuilderAnyFunction<T, int> itemCount;
  final bool staggered;
  final bool addSpacer;

  static const TextStyle titleStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  const CategorizedList({
    Key key,
    @required this.categories,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.titleBuilder,
    this.staggered = true,
    this.addSpacer = false,
  }) : super(key: key);

  const CategorizedList.builder({
    Key key,
    @required this.categories,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.titleBuilder,
    this.staggered = true,
    this.addSpacer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num i = 0;
    Iterable<Widget> cats = categories.map((category) {
      num index = i++;
      Widget title = DefaultTextStyle(
        child: titleBuilder(context, category, index),
        style:
            titleStyle.copyWith(color: Theme.of(context).textTheme.body1.color),
      );
      num count = itemCount(category, index);
      if (count == 0) {
        return null;
      }
      List<Widget> items =
          List.generate(count, (i) => itemBuilder(context, category, i));

      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[title] + items,
        ),
      );
    }).toList();

    return OrientationBuilder(
      builder: (context, orientation) {
        return StaggeredGridView.countBuilder(
          crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
          itemCount: addSpacer ? cats.length + 1 : cats.length,
          itemBuilder: (context, index) {
            if (index < cats.length) {
              Widget child = cats.elementAt(index);
              if (child != null) {
                return Padding(padding: const EdgeInsets.all(16), child: child);
              }
              return Container();
            }
            return MainView.bottomSpacer;
          },
          staggeredTileBuilder: (index) =>
              index < cats.length ? StaggeredTile.fit(1) : StaggeredTile.fit(2)
        );
      },
    );
  }
}
