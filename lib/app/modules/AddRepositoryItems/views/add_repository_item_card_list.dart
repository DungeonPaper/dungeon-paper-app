import 'package:dungeon_paper/app/modules/AddRepositoryItems/bindings/repository_item_form_binding.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/forms/repository_item_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRepositoryItemCardList<T, F extends EntityFilters>
    extends GetView<AddRepositoryItemsController<T, F>> {
  const AddRepositoryItemCardList({
    Key? key,
    required this.useFilters,
    required this.filtersBuilder,
    required this.filters,
    required this.children,
    this.extraData = const {},
    this.onSave,
  }) : super(key: key);

  final bool useFilters;
  final Widget Function(F filters, void Function(F filters) update)? filtersBuilder;
  final F filters;
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
                    () => RepositoryItemForm<T>(onSave: onSave!, extraData: extraData),
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
              const SizedBox(height: 80),
            ],
          ),
        ),
      ],
    );
  }
}
