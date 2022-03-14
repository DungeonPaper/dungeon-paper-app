import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddRepositoryItemsView<T, F extends EntityFilters<T>>
    extends GetView<AddRepositoryItemsController<T, F>> {
  AddRepositoryItemsView({
    Key? key,
    required this.title,
    required this.cardBuilder,
    required this.onAdd,
    this.filtersBuilder,
    this.filterFn,
  }) : super(key: key);

  final Widget title;
  final Widget Function(BuildContext context, T item,
      {required void Function(bool state) onSelect, required bool selected}) cardBuilder;
  final void Function(Iterable<T> items) onAdd;
  final pageStorageBucket = PageStorageBucket();
  final Widget Function(F filters, void Function(F filters) update)? filtersBuilder;
  final bool Function(T item, F filters)? filterFn;

  Iterable<T> get list =>
      controller.filterList(controller.repo.listByType<T>().values.toList(), filterFn);

  bool get useFilters => filtersBuilder != null;
  F get filters => controller.filters.value!;

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
          () => Column(
            children: [
              if (useFilters)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: filtersBuilder!(filters, controller.setFilters),
                ),
              Expanded(
                child: ListView(padding: const EdgeInsets.all(8).copyWith(top: 0), children: [
                  ...list.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: controller.isSelected(item)
                                  ? DwColors.success
                                  : Colors.transparent,
                            ),
                          ),
                          child: cardBuilder(
                            context,
                            item,
                            onSelect: (state) => controller.toggle(item, state),
                            selected: controller.isSelected(item),
                          ),
                        ),
                      )),
                ]),
              ),
            ],
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
