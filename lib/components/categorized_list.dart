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
  final num spacerCount;
  bool get _isChildrenBuilder => itemBuilder == null || itemCount == null;

  static const TextStyle titleStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  const CategorizedList({
    Key key,
    @required this.categories,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.titleBuilder,
    this.staggered = true,
    this.spacerCount = 0,
  }) : super(key: key);

  const CategorizedList.builder({
    Key key,
    @required this.categories,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.titleBuilder,
    this.staggered = true,
    this.spacerCount = 0,
  }) : super(key: key);

  CategorizedList.childrenBuilder({
    Key key,
    List<T> children,
    this.titleBuilder,
    this.spacerCount = 0,
    this.staggered = true,
  })  : categories = children,
        itemBuilder = null,
        itemCount = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    num i = 0;
    Iterable<Widget> cats = categories.map((category) {
      num index = i++;
      var builtTitle =
          titleBuilder == null ? null : titleBuilder(context, category, index);
      Widget title;

      if (builtTitle != null) {
        title = DefaultTextStyle(
          child: builtTitle,
          style: titleStyle.copyWith(
              color: Theme.of(context).textTheme.body1.color),
        );
      }
      num count = _isChildrenBuilder ? 1 : itemCount(category, index);
      if (count == 0) {
        return null;
      }
      List<Widget> items = List.generate(
          count,
          (i) => _isChildrenBuilder
              ? category
              : itemBuilder(context, category, i));

      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: title != null ? [title] + items : items,
        ),
      );
    }).toList();

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
              return MainView.bottomSpacer;
            },
            staggeredTileBuilder: (index) => index < cats.length
                ? StaggeredTile.fit(1)
                : StaggeredTile.fit(2));
      },
    );
  }
}
