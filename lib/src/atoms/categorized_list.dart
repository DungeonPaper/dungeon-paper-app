import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/expansion_states.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

typedef BuilderAnyFunction<T, E> = E Function(T category, num index);
typedef BuilderFunction<T> = Widget Function(
    BuildContext context, T category, num itemIndex);
typedef KeyBuilderFunction<T> = String Function(
    BuildContext context, T category, num itemIndex);
typedef BuilderFunctionWithCatIndex<T> = Widget Function(
    BuildContext context, T category, num itemIndex, num catIndex);

class CategorizedList<T> extends StatelessWidget {
  final Iterable<T> items;
  final BuilderFunctionWithCatIndex<T> itemBuilder;
  final BuilderFunction<T> titleBuilder;
  final KeyBuilderFunction<T> keyBuilder;
  final BuilderAnyFunction<T, int> itemCount;
  final bool staggered;
  final num spacerCount;
  final EdgeInsets itemMargin;
  final ScrollController scrollController;
  final bool saveExpansionStates;

  bool get _isChildrenBuilder => itemBuilder == null || itemCount == null;

  TextStyle titleStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyText2
      .copyWith(fontSize: 16.0, fontWeight: FontWeight.bold);

  const CategorizedList({
    Key key,
    List<T> children,
    this.titleBuilder,
    @required this.keyBuilder,
    this.spacerCount = 0,
    this.staggered = true,
    this.itemMargin = _defaultItemMargin,
    this.scrollController,
    this.saveExpansionStates = true,
  })  : items = children,
        itemBuilder = null,
        itemCount = null,
        super(key: key);

  const CategorizedList.builder({
    Key key,
    @required this.items,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.keyBuilder,
    this.titleBuilder,
    this.staggered = true,
    this.spacerCount = 0,
    this.itemMargin = _defaultItemMargin,
    this.scrollController,
    this.saveExpansionStates = true,
  }) : super(key: key);

  static const _defaultItemMargin = EdgeInsets.symmetric(horizontal: 16);

  @override
  Widget build(BuildContext context) {
    var cats = _itemsToWidgets(context);

    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) => StaggeredGridView.countBuilder(
            crossAxisCount: constraints.maxWidth < 450 ? 1 : 2,
            controller: scrollController,
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

      var titleTextStyle = titleStyle(context).copyWith(
        color: Theme.of(context).colorScheme.secondary,
      );
      if (builtTitle != null) {
        title = DefaultTextStyle(
          child: builtTitle,
          style: titleTextStyle,
        );
      }
      final count = _isChildrenBuilder ? 1 : itemCount(item.value, item.index);
      if (count == 0) {
        return null;
      }
      var outputItems = List<Widget>.generate(
          count,
          (j) => _isChildrenBuilder
              ? item.value
              : itemBuilder(context, item.value, j, item.index));

      final builtKey = keyBuilder?.call(context, item.value, item.index);

      if (title == null) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: outputItems,
        );
      }

      return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          unselectedWidgetColor: titleTextStyle.color,
        ),
        child: IconTheme(
          data:
              Theme.of(context).iconTheme.copyWith(color: titleTextStyle.color),
          child: ExpansionTile(
            tilePadding: EdgeInsets.only(right: 8),
            title: title,
            initiallyExpanded: expansionStates.isExpanded(builtKey),
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            children: outputItems,
            onExpansionChanged: _onExpansionChanged(builtKey),
          ),
        ),
      );
    }).toList();
  }

  void Function(bool) _onExpansionChanged(String key) {
    return (value) {
      if (key != null) {
        expansionStates.setExpansion(key, value);
      }
    };
  }

  ExpansionStates get expansionStates =>
      dwStore.state.prefs.settings.expansionStates;
}
