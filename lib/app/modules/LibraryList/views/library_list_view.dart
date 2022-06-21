import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'library_card_list.dart';

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

class LibraryListView<T extends WithMeta, F extends EntityFilters<T>>
    extends GetView<LibraryListController<T, F>> {
  LibraryListView({
    Key? key,
    required this.title,
    required this.cardBuilder,
    required this.filtersBuilder,
  }) : super(key: key);

  final Widget title;
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
                    LibraryCardList<T, F>(
                      group: FiltersGroup.playbook,
                      useFilters: useFilters,
                      filtersBuilder: filtersBuilder,
                      filters: playbookFilters,
                      extraData: controller.extraData,
                      children: controller.builtInList.map(
                        (item) => _wrapWithSelection(context, item, FiltersGroup.playbook),
                      ),
                    ),
                    LibraryCardList<T, F>(
                      group: FiltersGroup.my,
                      onSave: (item) => controller.saveCustomItem(controller.storageKey, item),
                      extraData: controller.extraData,
                      useFilters: useFilters,
                      filtersBuilder: filtersBuilder,
                      filters: myFilters,
                      children: controller.myList.map(
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
                          ? S.current.addWithCount(S.current.pluralize(
                              controller.selected.length,
                              S.current.entity(T),
                              S.current.entityPlural(T),
                            ))
                          : S.current.selectGeneric(nameFor(controller.selected.first))
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
          final onToggle = enabled ? () => controller.toggleItem(item, !selected) : null;

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
                      nameFor(item),
                      () => controller.deleteCustomItem(
                            controller.storageKey,
                            item,
                          ))
                  : null,
            ),
          );
        },
      );
}
