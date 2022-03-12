import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddRepositoryItemsView<T> extends GetView<AddRepositoryItemsController<T>> {
  AddRepositoryItemsView({
    Key? key,
    required this.title,
    required this.cardBuilder,
    required this.onAdd,
  }) : super(key: key);

  final Widget title;
  final Widget Function(BuildContext context, T item,
      {required void Function(bool state) onSelect, required bool selected}) cardBuilder;
  final void Function(List<T> items) onAdd;
  final pageStorageBucket = PageStorageBucket();

  List<T> get list => controller.service.listByType<T>().values.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: true,
      ),
      body: PageStorage(
        bucket: pageStorageBucket,
        child: Obx(
          () => ListView(
            padding: const EdgeInsets.all(8).copyWith(top: 0),
            children: list
                .map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color:
                                controller.isSelected(item) ? DwColors.success : Colors.transparent,
                          ),
                        ),
                        child: cardBuilder(
                          context,
                          item,
                          onSelect: (state) => controller.toggle(item, state),
                          selected: controller.isSelected(item),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton.extended(
          icon: controller.selected.isNotEmpty ? const Icon(Icons.add) : null,
          backgroundColor:
              controller.selected.isNotEmpty ? DwColors.success : Theme.of(context).disabledColor,
          onPressed: controller.selected.isNotEmpty
              ? () {
                  onAdd(controller.selected);
                  Get.back();
                }
              : null,
          label: Text(controller.selected.isNotEmpty
              ? S.current.addWithCount(S.current.pluralize(controller.selected.length,
                  S.current.entity(T.toString()), S.current.entityPlural(T.toString())))
              : S.current.selectToAdd(S.current.entityPlural(T.toString()))),
        ),
      ),
    );
  }
}
