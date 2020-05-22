import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

typedef E BuilderAnyFunction<T, E>(T category, num index);
typedef Widget BuilderFunction<T>(
    BuildContext context, T category, num itemIndex);
typedef Widget BuilderFunctionWithCatIndex<T>(
    BuildContext context, T category, num itemIndex, num catIndex);

class CategorizedList<T> extends StatelessWidget {
  final Iterable<T> items;
  final BuilderFunctionWithCatIndex<T> itemBuilder;
  final BuilderFunction<T> titleBuilder;
  final BuilderAnyFunction<T, int> itemCount;
  final bool staggered;
  final num spacerCount;
  bool get _isChildrenBuilder => itemBuilder == null || itemCount == null;

  static const TextStyle titleStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  const CategorizedList({
    Key key,
    List<T> children,
    this.titleBuilder,
    this.spacerCount = 0,
    this.staggered = true,
  })  : items = children,
        itemBuilder = null,
        itemCount = null,
        super(key: key);

  const CategorizedList.builder({
    Key key,
    @required this.items,
    @required this.itemCount,
    @required this.itemBuilder,
    this.titleBuilder,
    this.staggered = true,
    this.spacerCount = 0,
  }) : super(key: key);

  CategorizedList.childrenBuilder({
    Key key,
    List<T> children,
    this.titleBuilder,
    this.spacerCount = 0,
    this.staggered = true,
  })  : items = children,
        itemBuilder = null,
        itemCount = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> cats = _itemsToWidgets(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return StaggeredGridView.countBuilder(
            crossAxisCount: constraints.maxWidth < 450 ? 1 : 2,
            itemCount: cats.length + spacerCount,
            itemBuilder: (context, index) {
              if (index < cats.length) {
                Widget child = cats.elementAt(index);
                if (child != null) {
                  return Padding(
                      padding: const EdgeInsets.all(16), child: child);
                }
                return Container();
              }
              return BOTTOM_SPACER;
            },
            staggeredTileBuilder: (index) => index < cats.length
                ? StaggeredTile.fit(1)
                : StaggeredTile.fit(2));
      },
    );
  }

  List<Widget> _itemsToWidgets(BuildContext context) {
    num catIndex = 0;

    return items.map((item) {
      var builtTitle =
          titleBuilder == null ? null : titleBuilder(context, item, catIndex);
      Widget title;

      if (builtTitle != null) {
        title = DefaultTextStyle(
          child: builtTitle,
          style: titleStyle.copyWith(
              color: Theme.of(context).textTheme.bodyText2.color),
        );
      }
      num count = _isChildrenBuilder ? 1 : itemCount(item, catIndex);
      if (count == 0) {
        return null;
      }
      List<Widget> outputItems = List.generate(
          count,
          (j) => _isChildrenBuilder
              ? item
              : itemBuilder(context, item, j, catIndex));

      catIndex++;

      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) title,
            ...outputItems,
          ],
        ),
      );
    }).toList();
  }
}
