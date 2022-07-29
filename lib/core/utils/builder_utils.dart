import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ItemBuilder {
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;

  ItemBuilder._({
    required this.itemBuilder,
    required this.itemCount,
  });

  ListView createListView({
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    ChildIndexGetter? findChildIndexCallback,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
  }) =>
      _createListView(
        this,
        padding: padding,
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        cacheExtent: cacheExtent,
        semanticChildCount: semanticChildCount,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        restorationId: restorationId,
        clipBehavior: clipBehavior,
        findChildIndexCallback: findChildIndexCallback,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        itemExtent: itemExtent,
        prototypeItem: prototypeItem,
      );

  static ListView _createListView(
    ItemBuilder builder, {
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    ChildIndexGetter? findChildIndexCallback,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
  }) =>
      ListView.builder(
        itemBuilder: builder.itemBuilder,
        itemCount: builder.itemCount,
        padding: padding,
        scrollDirection: scrollDirection,
        reverse: reverse,
        controller: controller,
        primary: primary,
        physics: physics,
        shrinkWrap: shrinkWrap,
        cacheExtent: cacheExtent,
        semanticChildCount: semanticChildCount,
        dragStartBehavior: dragStartBehavior,
        keyboardDismissBehavior: keyboardDismissBehavior,
        restorationId: restorationId,
        clipBehavior: clipBehavior,
        findChildIndexCallback: findChildIndexCallback,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        itemExtent: itemExtent,
        prototypeItem: prototypeItem,
      );

  /// Creates a builder that builds a list of widgets from a list of items, leading, and trailing, without needing to
  /// manually fix the indexes of the items, especially useful if the items are dynamically generated.
  factory ItemBuilder.builder({
    required Widget Function(BuildContext context, int index) itemBuilder,
    required int itemCount,
    Widget Function(BuildContext context, int index)? leadingBuilder,
    int leadingCount = 0,
    Widget Function(BuildContext context, int index)? trailingBuilder,
    int trailingCount = 0,
  }) {
    final allCount = leadingCount + itemCount + trailingCount;
    final childrenStartIndex = leadingCount;
    final trailingStartIndex = childrenStartIndex + itemCount;

    return ItemBuilder._(
      itemBuilder: (context, index) {
        if (leadingBuilder != null && leadingCount > 0 && index < leadingCount) {
          return leadingBuilder(context, index);
        }
        if (index >= childrenStartIndex && index < trailingStartIndex) {
          return itemBuilder(context, index - leadingCount);
        }
        if (trailingBuilder != null) {
          return trailingBuilder(context, index - childrenStartIndex);
        }
        return const SizedBox.shrink();
        // return trailingBuilder(context, index - trailingStartIndex);
      },
      itemCount: allCount,
    );
  }

  /// Takes a list of widget functions and returns a [ItemBuilder] that will build a [ListView] with the given widgets,
  /// only calling them lazily.
  factory ItemBuilder.lazyChildren({
    required List<Widget Function()> children,
    List<Widget Function()> leading = const [],
    List<Widget Function()> trailing = const [],
  }) {
    final leadingCount = leading.length;
    final trailingCount = trailing.length;
    final childrenCount = children.length;
    final itemCount = leadingCount + childrenCount + trailingCount;
    final childrenStartIndex = leadingCount;
    final trailingStartIndex = childrenStartIndex + childrenCount;

    return ItemBuilder._(
      itemBuilder: (context, index) {
        if (index < leadingCount) {
          return leading[index]();
        }
        if (index >= childrenStartIndex && index < trailingStartIndex) {
          return children[index - leadingCount]();
        }
        // if (index >= trailingStartIndex) {
        return trailing[index - childrenStartIndex]();
        // }
        // return const SizedBox.shrink();
        // return trailing[index - trailingStartIndex](context);
      },
      itemCount: itemCount,
    );
  }
}
