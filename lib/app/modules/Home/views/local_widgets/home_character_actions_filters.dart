import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/widgets/atoms/checklist_menu_entry.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class HomeCharacterActionsFilters extends StatelessWidget {
  const HomeCharacterActionsFilters({
    super.key,
    required this.hidden,
    required this.onUpdateHidden,
  });

  final Set<Type> hidden;
  final void Function(Set<Type> filters) onUpdateHidden;

  @override
  Widget build(BuildContext context) {
    return MenuButton<Type>(
      icon: const Icon(Icons.filter_list_alt),
      items: [Move, Spell, Item]
          .map(
            (type) => ChecklistMenuEntry<Type>(
              value: type,
              checked: !hidden.contains(type),
              onChanged: (show) {
                onUpdateHidden(
                  !show! ? {...hidden, type} : {...hidden.where((element) => element != type)},
                );
              },
              label: Expanded(child: Text(tr.entityPlural(type))),
            ),
          )
          .toList(),
    );
  }
}
