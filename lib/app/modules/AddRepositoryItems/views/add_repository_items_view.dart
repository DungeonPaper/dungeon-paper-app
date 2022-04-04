import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'add_repository_item_card_list.dart';

typedef CardBuilder<T> = Widget Function(
  BuildContext context,
  T item, {
  required bool selected,
  required bool selectable,
  required Widget label,
  required Widget icon,
  void Function()? onToggle,
  void Function(T item)? onUpdate,
  void Function(T item)? onDelete,
});

class AddRepositoryItemsView<T extends WithMeta, F extends EntityFilters<T>>
    extends GetView<AddRepositoryItemsController<T, F>> {
  AddRepositoryItemsView({
    Key? key,
    required this.title,
    required this.cardBuilder,
    required this.onAdd,
    required this.selections,
    required this.storageKey,
    this.filtersBuilder,
    this.filterFn,
    this.extraData = const {},
  }) : super(key: key);

  final Widget title;
  final CardBuilder<T> cardBuilder;
  final void Function(Iterable<T> items) onAdd;
  final pageStorageBucket = PageStorageBucket();
  final Widget Function(
          FiltersGroup group, F filters, void Function(FiltersGroup group, F filters) update)?
      filtersBuilder;
  final bool Function(T item, F filters)? filterFn;
  final Iterable<T> selections;
  final String storageKey;
  final Map<String, dynamic> extraData;
  Iterable<T> get builtInList => controller.filterList(
      controller.repo.value.builtIn.listByType<T>().values.toList(),
      FiltersGroup.playbook,
      filterFn);
  Iterable<T> get myList => controller.filterList(
      controller.repo.value.my.listByType<T>().values.toList(), FiltersGroup.my, filterFn);

  bool get useFilters => filtersBuilder != null;
  F get playbookFilters => controller.filters[FiltersGroup.playbook]!;
  F get myFilters => controller.filters[FiltersGroup.my]!;

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
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                controller: controller.tabController,
                labelColor: Theme.of(context).colorScheme.onSurface,
                unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                tabs: [
                  Tab(child: Text(S.current.addRepoItemTabPlaybook)),
                  Tab(child: Text(S.current.myGeneric(S.current.entityPlural(T)))),
                  Tab(child: Text(S.current.addRepoItemTabOnline)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    AddRepositoryItemCardList<T, F>(
                      group: FiltersGroup.playbook,
                      useFilters: useFilters,
                      filtersBuilder: filtersBuilder,
                      filters: playbookFilters,
                      extraData: extraData,
                      children: builtInList.map(
                        (item) => _wrapWithSelection(context, item, FiltersGroup.playbook),
                      ),
                    ),
                    AddRepositoryItemCardList<T, F>(
                      group: FiltersGroup.my,
                      onSave: (item) => controller.saveCustomItem(storageKey, item),
                      extraData: extraData,
                      useFilters: useFilters,
                      filtersBuilder: filtersBuilder,
                      filters: myFilters,
                      children: myList.map(
                        (item) => _wrapWithSelection(context, item, FiltersGroup.my),
                      ),
                    ),
                    Container(),
                  ],
                ),
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
          label: Text(
            controller.selected.isNotEmpty
                ? S.current.addWithCount(S.current.pluralize(
                    controller.selected.length,
                    S.current.entity(T),
                    S.current.entityPlural(T),
                  ))
                : S.current.selectToAdd(S.current.entityPlural(T)),
          ),
        ),
      ),
    );
  }

  Widget _wrapWithSelection(BuildContext context, T item, FiltersGroup group) => Obx(
        () {
          var selected = controller.isSelected(item);
          var selectable = controller.isSelectable(item, selections);
          var onToggle = selectable ? () => controller.toggleItem(item, !selected) : null;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: controller.isSelected(item)
                    ? DwColors.success
                    : !controller.isSelectable(item, selections)
                        ? Colors.grey
                        : Colors.transparent,
              ),
            ),
            child: cardBuilder(
              context,
              item,
              selected: selected,
              selectable: selectable,
              onToggle: onToggle,
              label: Text(selectable
                  ? !selected
                      ? S.current.select
                      : S.current.remove
                  : S.current.alreadyAdded),
              icon: Icon(
                selectable
                    ? !selected
                        ? Icons.add
                        : Icons.remove
                    : Icons.check,
              ),
              onUpdate: group == FiltersGroup.my
                  ? (item) => controller.saveCustomItem(storageKey, item)
                  : null,
              onDelete: group == FiltersGroup.my
                  ? (item) => awaitDeleteConfirmation<T>(
                      context, nameFor(item), () => controller.deleteCustomItem(storageKey, item))
                  : null,
            ),
          );
        },
      );
}
