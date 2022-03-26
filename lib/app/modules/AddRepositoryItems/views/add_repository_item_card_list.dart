import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/bindings/repository_item_form_binding.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/forms/repository_item_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRepositoryItemCardList<T extends WithMeta, F extends EntityFilters>
    extends GetView<AddRepositoryItemsController<T, F>> {
  const AddRepositoryItemCardList({
    Key? key,
    required this.useFilters,
    required this.filtersBuilder,
    required this.filters,
    required this.group,
    required this.children,
    this.extraData = const {},
    this.onSave,
  }) : super(key: key);

  final bool useFilters;
  final Widget Function(
      FiltersGroup, F filters, void Function(FiltersGroup group, F filters) update)? filtersBuilder;
  final F filters;
  final FiltersGroup group;
  final Iterable<Widget> children;
  final void Function(T item)? onSave;
  final Map<String, dynamic> extraData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (useFilters)
          Padding(
            padding: const EdgeInsets.all(8),
            child: filtersBuilder!(group, filters, controller.setFilters),
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8).copyWith(top: 0),
            children: [
              if (onSave != null) ...[
                SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    style: ButtonThemes.primaryElevated(context),
                    onPressed: () => Get.to(
                      () => RepositoryItemForm<T>(
                        onSave: onSave!,
                        extraData: extraData,
                        type: ItemFormType.create,
                      ),
                      binding: RepositoryItemFormBinding(),
                    ),
                    label: Text(S.current.createGeneric(S.current.entity(T))),
                    icon: const Icon(Icons.add),
                  ),
                ),
                const Divider(height: 32),
              ],
              ...children.map(
                (child) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: child,
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ],
    );
  }
}
