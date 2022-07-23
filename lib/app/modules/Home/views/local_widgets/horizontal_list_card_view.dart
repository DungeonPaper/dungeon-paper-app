import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/modules/Home/views/expanded_card_dialog_view.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalCardListView<T extends WithMeta> extends StatelessWidget {
  HorizontalCardListView({
    Key? key,
    required this.cardSize,
    required this.items,
    required this.cardBuilder,
    required this.expandedCardBuilder,
    this.leading = const [],
    this.trailing = const [],
  }) : super(key: key);

  final Size cardSize;
  final Widget Function(BuildContext context, T item, int index, void Function() onTap) cardBuilder;
  final Widget Function(
    BuildContext context,
    T item,
    int index,
    // void Function(Iterable<T>) onUpdate
  ) expandedCardBuilder;
  final Iterable<T> items;
  final itemsObs = <T>[].obs;
  final List<Widget> leading;
  final List<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }
    final displayedItems = enumerate(itemsObs.isEmpty ? items : itemsObs);

    final builder = ItemBuilder.builder(
      leadingCount: leading.length,
      leadingBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: SizedBox(
          width: cardSize.width,
          child: leading[index],
        ),
      ),
      itemCount: displayedItems.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(right: index == displayedItems.length ? 0 : 8),
        child: _buildCard(
          context,
          displayedItems.elementAt(index),
        ),
      ),
      trailingCount: trailing.length,
      trailingBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 8),
        child: SizedBox(
          width: cardSize.width,
          child: trailing[index],
        ),
      ),
    );

    return SizedBox(
      height: cardSize.height,
      width: double.infinity,
      // width: 200,
      child: ListView.builder(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // itemExtent: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: builder.itemBuilder,
        itemCount: builder.itemCount,
      ),
    );
  }

  SizedBox _buildCard(BuildContext context, Enumerated<dynamic> item) {
    return SizedBox(
      width: cardSize.width,
      child: Hero(
        tag: getKeyFor(item.value),
        child: cardBuilder(
          context,
          item.value,
          item.index,
          () => Get.dialog(
            ExpandedCardDialogView<T>(
              // heroTag: getKeyFor(item.value),
              heroTag: null,
              builder: (context) =>
                  // ignore: unnecessary_null_comparison
                  item.value != null && item.index < items.length
                      ? expandedCardBuilder(
                          context,
                          item.value,
                          item.index,
                          // onUpdate
                        )
                      : Container(),
            ),
            // opaque: false,
            // transition: Transition.downToUp,
            // duration: Duration(milliseconds: 500),
          ),
          // onUpdate,
        ),
      ),
    );
  }

  String getKeyFor(T item) => [item.runtimeType, item.key].join('-');

  void onUpdate(Iterable<T> items) {
    itemsObs.value = [...items];
  }
}
