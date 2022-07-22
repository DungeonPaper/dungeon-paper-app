import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/modules/Home/views/expanded_card_dialog_view.dart';
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
      return Container();
    }
    final displayedItems = enumerate(itemsObs.isEmpty ? items : itemsObs);

    return SizedBox(
      height: cardSize.height,
      width: double.infinity,
      // width: 200,
      child: ListView.builder(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // itemExtent: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: leading.length + displayedItems.length + trailing.length,
        itemBuilder: (context, index) => index < leading.length
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SizedBox(
                  width: cardSize.width,
                  child: leading[index],
                ),
              )
            : index < leading.length + displayedItems.length
                ? Padding(
                    padding: EdgeInsets.only(right: index == displayedItems.length ? 0 : 8),
                    child: _buildCard(
                      context,
                      displayedItems.elementAt(index - leading.length),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: SizedBox(
                      width: cardSize.width,
                      child: trailing[index - leading.length - displayedItems.length],
                    ),
                  ),
        // children: [
        //   ...leading.map(
        //     (c) => Padding(
        //       padding: const EdgeInsets.only(right: 8),
        //       child: SizedBox(
        //         width: cardSize.width,
        //         child: c,
        //       ),
        //     ),
        //   ),
        //   for (final item in enumerate(displayedItems))
        //     Padding(
        //       padding: EdgeInsets.only(right: item.index == items.length - 1 ? 0 : 8),
        //       child: _buildCard(context, item),
        //     ),
        //   ...trailing.map(
        //     (c) => Padding(
        //       padding: const EdgeInsets.only(left: 8),
        //       child: SizedBox(
        //         width: cardSize.width,
        //         child: c,
        //       ),
        //     ),
        //   ),
        // ],
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
                  item.value != null && !item.isLast
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
