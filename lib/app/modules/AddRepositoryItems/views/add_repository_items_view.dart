import 'package:dungeon_paper/app/modules/AddRepositoryItems/bindings/repository_item_form_binding.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/forms/repository_item_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../themes/button_themes.dart';

class AddRepositoryItemsView<T, F extends EntityFilters<T>>
    extends GetView<AddRepositoryItemsController<T, F>> {
  AddRepositoryItemsView({
    Key? key,
    required this.title,
    required this.cardBuilder,
    required this.onAdd,
    required this.selections,
    this.filtersBuilder,
    this.filterFn,
  }) : super(key: key);

  final Widget title;
  final Widget Function(BuildContext context, T item,
      {required void Function(bool state) onSelect,
      required bool selected,
      required bool selectable}) cardBuilder;
  final void Function(Iterable<T> items) onAdd;
  final pageStorageBucket = PageStorageBucket();
  final Widget Function(F filters, void Function(F filters) update)? filtersBuilder;
  final bool Function(T item, F filters)? filterFn;
  final Iterable<T> selections;

  Iterable<T> get builtInList =>
      controller.filterList(controller.repo.builtIn.listByType<T>().values.toList(), filterFn);
  Iterable<T> get myList =>
      controller.filterList(controller.repo.my.listByType<T>().values.toList(), filterFn);

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
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                controller: controller.tabController,
                tabs: [
                  Tab(child: Text('Rulebook')),
                  Tab(child: Text('Online')),
                  Tab(child: Text('My ${T}s')),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: [
                    AddRepositoryItemCardList<T, F>(
                      useFilters: useFilters,
                      filtersBuilder: filtersBuilder,
                      filters: filters,
                      children: builtInList.map(
                        (item) => _wrapWithSelection(
                          item,
                          cardBuilder(
                            context,
                            item,
                            onSelect: (state) => controller.toggle(item, state),
                            selected: controller.isSelected(item),
                            selectable: controller.isSelectable(item, selections),
                          ),
                        ),
                      ),
                    ),
                    Container(),
                    AddRepositoryItemCardList<T, F>(
                      onSave: (item) => null,
                      useFilters: useFilters,
                      filtersBuilder: filtersBuilder,
                      filters: filters,
                      children: myList.map(
                        (item) => _wrapWithSelection(
                          item,
                          cardBuilder(
                            context,
                            item,
                            onSelect: (state) => controller.toggle(item, state),
                            selected: controller.isSelected(item),
                            selectable: controller.isSelectable(item, selections),
                          ),
                        ),
                      ),
                    ),
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
          label: Text(controller.selected.isNotEmpty
              ? S.current.addWithCount(S.current.pluralize(controller.selected.length,
                  S.current.entity(T.toString()), S.current.entityPlural(T.toString())))
              : S.current.selectToAdd(S.current.entityPlural(T.toString()))),
        ),
      ),
    );
  }

  Widget _wrapWithSelection(T item, Widget child) => Container(
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
        child: child,
      );
}

class AddRepositoryItemCardList<T, F extends EntityFilters>
    extends GetView<AddRepositoryItemsController<T, F>> {
  const AddRepositoryItemCardList({
    Key? key,
    required this.useFilters,
    required this.filtersBuilder,
    required this.filters,
    required this.children,
    this.onSave,
  }) : super(key: key);

  final bool useFilters;
  final Widget Function(F filters, void Function(F filters) update)? filtersBuilder;
  final F filters;
  final Iterable<Widget> children;
  final void Function(T item)? onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (useFilters)
          Padding(
            padding: const EdgeInsets.all(8),
            child: filtersBuilder!(filters, controller.setFilters),
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8).copyWith(top: 0),
            children: [
              if (onSave != null)
                OutlinedButton.icon(
                  style: ButtonThemes.primaryOutlined(context),
                  onPressed: () => Get.to(
                    () => RepositoryItemForm<T>(
                      onSave: (item) => debugPrint('onSave $item'),
                    ),
                    binding: RepositoryItemFormBinding(),
                  ),
                  label: Text(S.current.addCustomGeneric(S.current.entity(T))),
                  icon: const Icon(Icons.add),
                ),
              ...children.map(
                (child) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
