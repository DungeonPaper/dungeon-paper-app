import 'package:flutter/material.dart';

class ItemBuilder {
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;

  ItemBuilder._({
    required this.itemBuilder,
    required this.itemCount,
  });

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
