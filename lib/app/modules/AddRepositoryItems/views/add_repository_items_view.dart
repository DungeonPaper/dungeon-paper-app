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
    required this.preSelections,
    required this.storageKey,
    this.filtersBuilder,
    this.filterFn,
    this.extraData = const {},
    this.multiple = true,
  }) : super(key: key);

  final Widget title;
  final CardBuilder<T> cardBuilder;
  final void Function(Iterable<T> items) onAdd;
  final pageStorageBucket = PageStorageBucket();
  final Widget Function(
          FiltersGroup group, F filters, void Function(FiltersGroup group, F filters) update)?
      filtersBuilder;
  final bool Function(T item, F filters)? filterFn;
  final bool multiple;
  final Iterable<T> preSelections;
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
                      onSave: (item) =>
                          controller.saveCustomItem(storageKey, item, preSelections, multiple),
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
          icon: controller.selected.isNotEmpty
              ? multiple
                  ? const Icon(Icons.add)
                  : const Icon(Icons.check)
              : null,
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
                ? multiple
                    ? S.current.addWithCount(S.current.pluralize(
                        controller.selected.length,
                        S.current.entity(T),
                        S.current.entityPlural(T),
                      ))
                    : S.current.selectGeneric(nameFor(controller.selected.first))
                : S.current.selectToAdd(multiple ? S.current.entityPlural(T) : S.current.entity(T)),
          ),
        ),
      ),
    );
  }

  Widget _wrapWithSelection(BuildContext context, T item, FiltersGroup group) => Obx(
        () {
          var isPreSelected = controller.isPreSelected(item, preSelections, multiple);
          var selected = controller.isSelected(item, preSelections, multiple);
          var enabled = controller.isEnabled(item, preSelections, multiple);
          var onToggle = enabled
              ? () => controller.toggleItem(item, !selected, preSelections, multiple)
              : null;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: selected
                    ? multiple && isPreSelected
                        ? Colors.grey
                        : DwColors.success
                    : multiple && !controller.isEnabled(item, preSelections, multiple)
                        ? Colors.grey
                        : Colors.transparent,
              ),
            ),
            child: cardBuilder(
              context,
              item,
              selected: selected,
              selectable: enabled,
              onToggle: onToggle,
              label: Text(
                enabled
                    ? !selected
                        ? S.current.select
                        : multiple
                            ? S.current.remove
                            : S.current.unselect
                    : multiple
                        ? S.current.alreadyAdded
                        : S.current.select,
              ),
              icon: Icon(
                enabled
                    ? !selected
                        ? multiple
                            ? Icons.add
                            : Icons.check
                        : Icons.remove
                    : multiple
                        ? Icons.add
                        : Icons.check,
              ),
              onUpdate: group == FiltersGroup.my
                  ? (item) => controller.saveCustomItem(storageKey, item, preSelections, multiple)
                  : null,
              onDelete: group == FiltersGroup.my
                  ? (item) => awaitDeleteConfirmation<T>(context, nameFor(item),
                      () => controller.deleteCustomItem(storageKey, item, preSelections, multiple))
                  : null,
            ),
          );
        },
      );
}
