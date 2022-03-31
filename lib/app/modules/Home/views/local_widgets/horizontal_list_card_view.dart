import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/app/modules/Home/views/expanded_card_dialog_view.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalCardListView<T> extends StatelessWidget {
  HorizontalCardListView({
    Key? key,
    required this.cardSize,
    required this.items,
    required this.cardBuilder,
    required this.expandedCardBuilder,
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

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Container();
    }
    return SizedBox(
      height: cardSize.height,
      width: double.infinity,
      // width: 200,
      child: ListView(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // itemExtent: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          for (final item in enumerate(itemsObs.isEmpty ? items : itemsObs))
            Padding(
              padding: EdgeInsets.only(right: item.index == items.length - 1 ? 0 : 8),
              child: SizedBox(
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
                        builder: (context) => expandedCardBuilder(
                          context,
                          item.value,
                          item.index,
                          // onUpdate
                        ),
                      ),
                      // opaque: false,
                      // transition: Transition.downToUp,
                      // duration: Duration(milliseconds: 500),
                    ),
                    // onUpdate,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String getKeyFor(T item) => [item.runtimeType, keyFor(item)].join('-');

  void onUpdate(Iterable<T> items) {
    itemsObs.value = [...items];
  }
}
