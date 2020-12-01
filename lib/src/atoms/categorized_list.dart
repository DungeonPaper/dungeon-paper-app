import 'package:dungeon_paper/src/redux/shared_preferences/expansion_states.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:uuid/uuid.dart';

typedef BuilderAnyFunction<T, E> = E Function(T category, num index);
typedef BuilderFunction<T> = Widget Function(
    BuildContext context, T category, num itemIndex);
typedef KeyBuilderFunction<T> = String Function(
    BuildContext context, T category, num itemIndex);
typedef BuilderFunctionWithCatIndex<T> = Widget Function(
    BuildContext context, T category, num itemIndex, num catIndex);

class CategorizedList<T> extends StatefulWidget {
  final Iterable<T> items;
  final BuilderFunctionWithCatIndex<T> itemBuilder;
  final BuilderFunction<T> titleBuilder;
  final KeyBuilderFunction<T> keyBuilder;
  final BuilderAnyFunction<T, int> itemCount;
  final bool staggered;
  final double bottomSpacerHeight;
  final double topSpacerHeight;
  final EdgeInsets itemMargin;
  final ScrollController scrollController;

  CategorizedList({
    Key key,
    List<T> children,
    this.titleBuilder,
    @required this.keyBuilder,
    this.topSpacerHeight = 0.0,
    this.bottomSpacerHeight = 0.0,
    this.staggered = true,
    this.itemMargin = _defaultItemMargin,
    this.scrollController,
  })  : items = children,
        itemBuilder = null,
        itemCount = null,
        super(key: key);

  CategorizedList.builder({
    Key key,
    @required this.items,
    @required this.itemCount,
    @required this.itemBuilder,
    @required this.keyBuilder,
    this.titleBuilder,
    this.staggered = true,
    this.topSpacerHeight = 0.0,
    this.bottomSpacerHeight = 0.0,
    this.itemMargin = _defaultItemMargin,
    this.scrollController,
  }) : super(key: key);

  static const _defaultItemMargin = EdgeInsets.symmetric(horizontal: 16);

  @override
  _CategorizedListState<T> createState() => _CategorizedListState<T>();
}

class _CategorizedListState<T> extends State<CategorizedList<T>> {
  final String sessionKey = Uuid().v4();

  bool get _isChildrenBuilder =>
      widget.itemBuilder == null || widget.itemCount == null;

  TextStyle titleStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyText2
      .copyWith(fontSize: 16.0, fontWeight: FontWeight.bold);

  int get bottomSpacerCount =>
      clamp01(widget.bottomSpacerHeight.toInt()).toInt();

  int get topSpacerCount => clamp01(widget.topSpacerHeight.toInt()).toInt();

  bool get saveExpansionStates => widget.keyBuilder != null;

  @override
  Widget build(BuildContext context) {
    final cats = _itemsToWidgets(context);

    return OrientationBuilder(
      // key: PageStorageKey('$sessionKey: $sessionKey'),
      builder: (context, orientation) {
        return Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            unselectedWidgetColor: titleStyle(context).color,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return StaggeredGridView.countBuilder(
                crossAxisCount: constraints.maxWidth < 450 ? 1 : 2,
                controller: widget.scrollController,
                itemCount: cats.length + bottomSpacerCount + topSpacerCount,
                itemBuilder: (context, index) {
                  if (index < topSpacerCount) {
                    return SizedBox(height: widget.topSpacerHeight);
                  }
                  index -= topSpacerCount;
                  if (index < cats.length) {
                    final child = cats.elementAt(index);
                    if (child != null) {
                      return Padding(
                        padding: widget.itemMargin,
                        child: child,
                      );
                    }
                    return Container();
                  }
                  return SizedBox(height: widget.bottomSpacerHeight);
                },
                staggeredTileBuilder: (index) => index < cats.length
                    ? StaggeredTile.fit(1)
                    : StaggeredTile.fit(2),
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> _itemsToWidgets(BuildContext context) {
    return enumerate(widget.items)
        .map((item) => _itemBuilder(context, item.index, item.value))
        .toList();
  }

  Widget _itemBuilder(BuildContext context, int index, T item) {
    final builtTitle = widget.titleBuilder?.call(context, item, index);
    final titleTextStyle = titleStyle(context).copyWith(
      color: Theme.of(context).colorScheme.secondary,
    );
    final count = _isChildrenBuilder ? 1 : widget.itemCount(item, index);
    final outputItems = List<Widget>.generate(
      count,
      (j) => _isChildrenBuilder
          ? item
          : widget.itemBuilder(context, item, j, index),
    );

    final builtKey = widget.keyBuilder?.call(context, item, index);
    final charId = dwStore.state.characters.current?.documentID;
    final title = builtTitle != null
        ? DefaultTextStyle(
            child: builtTitle,
            style: titleTextStyle,
          )
        : null;

    if (count == 0) {
      return null;
    }

    if (title == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: outputItems,
      );
    }

    return Container(
      child: ExpansionTile(
        title: title,
        key: PageStorageKey('$sessionKey-$index-$charId-expansion'),
        initiallyExpanded: expansionStates.isExpanded(builtKey),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        tilePadding: EdgeInsets.only(right: 8),
        onExpansionChanged: _onExpansionChanged(builtKey),
        children: outputItems,
      ),
    );
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
