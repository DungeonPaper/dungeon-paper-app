import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntityFiltersView<T, F extends EntityFilters<T>> extends StatelessWidget {
  EntityFiltersView({
    Key? key,
    required this.filters,
    required this.onChange,
    required this.searchController,
    this.leading = const [],
    this.trailing = const [],
  }) : super(key: key);

  final F filters;
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
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: S.current.searchPlaceholderEntity(S.current.entity(Move)),
          ),
        ),
        ...trailing,
      ],
    );
  }
}
