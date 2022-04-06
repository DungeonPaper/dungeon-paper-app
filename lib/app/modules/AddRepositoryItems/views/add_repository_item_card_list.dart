import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
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
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(top: 32),
            child: ListView(
              padding: const EdgeInsets.all(8).copyWith(top: 0),
              children: [
                const SizedBox(height: 40),
                if (onSave != null) ...[
                  SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      style: ButtonThemes.primaryElevated(context),
                      onPressed: () => Get.to(
                        () => RepositoryItemForm<T>(
                          onSave: onSave!,
                          type: ItemFormType.create,
                        ),
                        binding: RepositoryItemFormBinding<T>(
                          item: _createEmpty(),
                          extraData: extraData,
                        ),
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
        ),
        if (useFilters)
          Padding(
            padding: const EdgeInsets.all(8),
            child: filtersBuilder!(group, filters, controller.setFilters),
          ),
      ],
    );
  }

  T _createEmpty() {
    switch (T) {
      case Move:
        return Move.empty().copyWithInherited(
          classKeys: extraData['classKeys'],
        ) as T;
      case Spell:
        return Spell.empty().copyWithInherited(
          classKeys: extraData['classKeys'],
        ) as T;
      case Item:
        return Item.empty().copyWithInherited() as T;
      default:
        throw UnsupportedError('createEmpty: Type $T is not supported');
    }
  }
}
