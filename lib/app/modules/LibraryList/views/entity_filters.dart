import 'dart:math';

import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/search_field.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';

class EntityFiltersView<T, F extends EntityFilters<T>> extends StatelessWidget {
  EntityFiltersView({
    Key? key,
    required this.filters,
    required this.emptyFilters,
    required this.onChange,
    required this.searchController,
    this.filterWidgetsBuilder,
    this.leading = const [],
    this.trailing = const [],
  }) : super(key: key);

  final F filters;
  final F emptyFilters;
  final List<Widget> Function(BuildContext context, F filters)? filterWidgetsBuilder;
  final service = Get.find<RepositoryService>();
  final void Function(F) onChange;
  final TextEditingController searchController;
  final Iterable<Widget> leading;
  final Iterable<Widget> trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...leading,
        if (leading.isNotEmpty) const SizedBox(height: 8),
        SearchField(
          controller: searchController,
          hintText: S.current.searchPlaceholderGeneric(S.current.entity(T)),
          trailing: filterWidgetsBuilder != null
              ? [
                  _FiltersWidgetsBuilder<F>(
                    filters: filters,
                    emptyFilters: emptyFilters,
                    onChange: onChange,
                    filterWidgetsBuilder: filterWidgetsBuilder!,
                  ),
                ]
              : [],
        ),
        if (trailing.isNotEmpty) const SizedBox(height: 8),
        ...trailing,
      ],
    );
  }
}

class _FiltersWidgetsBuilder<F extends EntityFilters> extends StatelessWidget {
  const _FiltersWidgetsBuilder({
    Key? key,
    required this.filters,
    required this.emptyFilters,
    required this.filterWidgetsBuilder,
    required this.onChange,
  }) : super(key: key);

  final F filters;
  final F emptyFilters;
  final List<Widget> Function(BuildContext context, F filters) filterWidgetsBuilder;
  final void Function(F) onChange;

  @override
  Widget build(BuildContext context) {
    return PrimaryChip(
      // backgroundColor: filters.activeFilterCount > 0 ? Theme.of(context).indicatorColor : null,
      // labelStyle: TextStyle(
      //   color: filters.activeFilterCount > 0 ? Theme.of(context).colorScheme.onPrimary : null,
      // ),
      icon: const Icon(Icons.filter_list_alt, size: 20),
      label: filters.activeFilterCount.toString(),
      // visualDensity: VisualDensity.compact,
      onDeleted: filters.activeFilterCount > 0
          ? () {
              onChange(emptyFilters);
              filters.controller.add(emptyFilters);
            }
          : null,
      deleteButtonTooltip: S.current.libraryListNoItemsFoundClearFiltersButton,
      onPressed: () => showPopover(
        context: context,
        height: max(
          96,
          filters.totalFilterCount * 64 + 32 + (16 * (filters.totalFilterCount - 1)),
        ),
        width: 300,
        backgroundColor: Theme.of(context).cardColor,
        // direction: PopoverDirection.right,
        bodyBuilder: (context) => _FiltersPopover<F>(
          filterWidgetsBuilder: filterWidgetsBuilder,
          filters: filters,
        ),
      ),
    );
  }
}

class _FiltersPopover<F extends EntityFilters> extends StatelessWidget {
  const _FiltersPopover({
    Key? key,
    required this.filters,
    required this.filterWidgetsBuilder,
  }) : super(key: key);

  final F filters;
  final List<Widget> Function(BuildContext context, F filters) filterWidgetsBuilder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: filters.onChanged,
      builder: (context, data) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: enumerate(filterWidgetsBuilder(context, filters))
                .map(
                  (e) => Container(
                    padding: e.index == filters.totalFilterCount - 1
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(bottom: 16),
                    height: e.index == filters.totalFilterCount - 1 ? 64 : 80,
                    child: e.value,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
