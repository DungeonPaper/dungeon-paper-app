import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

typedef BuilderAnyFunction<T, E> = E Function(T category, num index);
typedef BuilderFunction<T> = Widget Function(
    BuildContext context, T category, num itemIndex);
typedef BuilderFunctionWithCatIndex<T> = Widget Function(
    BuildContext context, T category, num itemIndex, num catIndex);

class CategorizedList<T> extends StatelessWidget {
  final Iterable<T> items;
  final BuilderFunctionWithCatIndex<T> itemBuilder;
  final BuilderFunction<T> titleBuilder;
  final BuilderAnyFunction<T, int> itemCount;
  final bool staggered;
  final num spacerCount;
  final EdgeInsets itemMargin;
  bool get _isChildrenBuilder => itemBuilder == null || itemCount == null;

  static const TextStyle titleStyle =
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);

  const CategorizedList({
    Key key,
    List<T> children,
    this.titleBuilder,
    this.spacerCount = 0,
    this.staggered = true,
    this.itemMargin = const EdgeInsets.all(16),
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
    this.itemMargin = const EdgeInsets.all(16),
  }) : super(key: key);

  CategorizedList.childrenBuilder({
    Key key,
    List<T> children,
    this.titleBuilder,
    this.spacerCount = 0,
    this.staggered = true,
    this.itemMargin = const EdgeInsets.all(16),
  })  : items = children,
        itemBuilder = null,
        itemCount = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var cats = _itemsToWidgets(context);

    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) => StaggeredGridView.countBuilder(
            crossAxisCount: constraints.maxWidth < 450 ? 1 : 2,
            itemCount: cats.length + spacerCount,
            itemBuilder: (context, index) {
              if (index < cats.length) {
                var child = cats.elementAt(index);
                if (child != null) {
                  return Padding(
                    padding: itemMargin,
                    child: child,
                  );
                }
                return Container();
              }
              return BOTTOM_SPACER;
            },
            staggeredTileBuilder: (index) => index < cats.length
                ? StaggeredTile.fit(1)
                : StaggeredTile.fit(2),
          ),
        );
      },
    );
  }

  List<Widget> _itemsToWidgets(BuildContext context) {
    return enumerate(items).map((item) {
      var builtTitle = titleBuilder == null
          ? null
          : titleBuilder(context, item.value, item.index);
      Widget title;

      if (builtTitle != null) {
        title = DefaultTextStyle(
          child: builtTitle,
          style: titleStyle.copyWith(
              color: Theme.of(context).textTheme.bodyText2.color),
        );
      }
      num count = _isChildrenBuilder ? 1 : itemCount(item.value, item.index);
      if (count == 0) {
        return null;
      }
      var outputItems = List<Widget>.generate(
          count,
          (j) => _isChildrenBuilder
              ? item.value
              : itemBuilder(context, item.value, j, item.index));

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
