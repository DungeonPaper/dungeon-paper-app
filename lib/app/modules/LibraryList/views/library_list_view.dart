import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'library_card_list.dart';

typedef CardBuilder<T> = Widget Function(BuildContext context, CardBuilderData<T> data);

class CardBuilderData<T> {
  final T item;
  final bool selected;
  final bool selectable;
  final Widget label;
  final Widget icon;
  final void Function()? onToggle;
  final void Function(T item)? onUpdate;
  final void Function(T item)? onDelete;
  final List<String> highlightWords;

  CardBuilderData({
    required this.item,
    required this.selected,
    required this.selectable,
    required this.label,
    required this.icon,
    required this.highlightWords,
    this.onToggle,
    this.onUpdate,
    this.onDelete,
  });
}

class LibraryListView<T extends WithMeta, F extends EntityFilters<T>>
    extends GetView<LibraryListController<T, F>> {
  LibraryListView({
    Key? key,
    this.title,
    required this.cardBuilder,
    required this.filtersBuilder,
  }) : super(key: key);

  final Widget? title;
  final CardBuilder<T> cardBuilder;
  final pageStorageBucket = PageStorageBucket();
  final Widget Function(
          FiltersGroup group, F filters, void Function(FiltersGroup group, F filters) update)?
      filtersBuilder;

  bool get useFilters => filtersBuilder != null;
  F get playbookFilters => controller.filters[FiltersGroup.playbook]!;
  F get myFilters => controller.filters[FiltersGroup.my]!;

  @override
  Widget build(BuildContext context) {
    final entityTitleName = controller.multiple || !controller.selectable
        ? S.current.entityPlural(T)
        : S.current.entity(T);

    return Scaffold(
      appBar: AppBar(
        title: title ??
            Text(
              controller.selectable
                  ? S.current.selectGeneric(entityTitleName)
                  : S.current.viewGeneric(entityTitleName),
            ),
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
                  // Tab(child: Text(S.current.addRepoItemTabOnline)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    LibraryCardList<T, F>.builder(
                      group: FiltersGroup.playbook,
                      useFilters: useFilters,
                      filtersBuilder: filtersBuilder,
                      filters: playbookFilters,
                      extraData: controller.extraData,
                      totalItemCount: controller.builtInListRaw.length,
                      itemCount: controller.builtInList.length,
                      itemBuilder: (context, index) {
                        final item = controller.builtInList.elementAt(index);
                        return _wrapWithSelection(context, item, FiltersGroup.playbook);
                      },
                    ),
                    LibraryCardList<T, F>.builder(
                      group: FiltersGroup.my,
                      onSave: (item) => controller.saveCustomItem(controller.storageKey, item),
                      extraData: controller.extraData,
                      useFilters: useFilters,
                      filtersBuilder: filtersBuilder,
                      filters: myFilters,
                      totalItemCount: controller.myListRaw.length,
                      itemCount: controller.myList.length,
                      itemBuilder: (context, index) {
                        final item = controller.myList.elementAt(index);
                        return _wrapWithSelection(context, item, FiltersGroup.my);
                      },
                    ),
                    // Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => controller.onAdd.obs.value != null
            ? AdvancedFloatingActionButton.extended(
                icon: controller.selected.isNotEmpty
                    ? controller.multiple
                        ? const Icon(Icons.add)
                        : const Icon(Icons.check)
                    : null,
                onPressed: controller.selected.isNotEmpty
                    ? () {
                        controller.onAdd!(controller.selectedWithMeta);
                        Get.back();
                      }
                    : null,
                label: Text(
                  controller.selected.isNotEmpty
                      ? controller.multiple
                          ? S.current.addGeneric(
                              S.current.pluralize(
                                controller.selected.length,
                                S.current.entity(T),
                                S.current.entityPlural(T),
                              ),
                            )
                          : S.current.selectGeneric(controller.selected.first.displayName)
                      : S.current.selectToAdd(
                          controller.multiple ? S.current.entityPlural(T) : S.current.entity(T),
                        ),
                ),
              )
            : Container(),
      ),
    );
  }

  Widget _wrapWithSelection(BuildContext context, T item, FiltersGroup group) => Obx(
        () {
          final isPreSelected = controller.isPreSelected(item);
          final selected = controller.isSelected(item);
          final enabled = controller.isEnabled(item);
          final selectable = controller.selectable;
          final onToggle = enabled ? () => controller.toggleItem(item, !selected) : null;
          final cardData = CardBuilderData<T>(
              item: item,
              selected: selected,
              selectable: selectable && enabled,
              onToggle: onToggle,
              label: Text(
                enabled
                    ? !selected
                        ? S.current.select
                        : controller.multiple
                            ? S.current.remove
                            : S.current.unselect
                    : controller.multiple
                        ? S.current.alreadyAdded
                        : S.current.select,
              ),
              icon: Icon(
                enabled
                    ? !selected
                        ? controller.multiple
                            ? Icons.add
                            : Icons.check
                        : Icons.remove
                    : controller.multiple
                        ? Icons.add
                        : Icons.check,
              ),
              onUpdate: group == FiltersGroup.my
                  ? (item) => controller.saveCustomItem(controller.storageKey, item)
                  : null,
              onDelete: group == FiltersGroup.my
                  ? (item) => awaitDeleteConfirmation<T>(
                        context,
                        item.displayName,
                        () => controller.deleteCustomItem(
                          controller.storageKey,
                          item,
                        ),
                      )
                  : null,
              highlightWords: [controller.search[group]!.value.text]);

          return Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(
                width: 2,
                color: selected
                    ? controller.multiple && isPreSelected
                        ? Colors.grey
                        : DwColors.success
                    : controller.multiple && !controller.isEnabled(item)
                        ? Colors.grey
                        : Colors.transparent,
              ),
            ),
            child: cardBuilder(context, cardData),
          );
        },
      );
}
