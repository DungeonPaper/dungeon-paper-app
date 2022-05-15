import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeCharacterActionsFilters extends StatelessWidget {
  const HomeCharacterActionsFilters({
    Key? key,
    required this.hidden,
    required this.onUpdateHidden,
  }) : super(key: key);

  final Set<String> hidden;
  final void Function(Set<String> filters) onUpdateHidden;

  @override
  Widget build(BuildContext context) {
    return MenuButton<String>(
      icon: const Icon(Icons.filter_list_alt),
      items: ['Move', 'Spell', 'Item']
          .map(
            (type) => MenuEntry(
              id: type,
              icon: SizedBox(
                width: 30,
                child: Checkbox(
                  value: !hidden.contains(type),
                  onChanged: (show) {
                    onUpdateHidden(!show!
                        ? {...hidden, type}
                        : {...hidden.where((element) => element != type)});
                  },
                ),
              ),
              label: Expanded(child: Text(S.current.entityPlural(type))),
              onSelect: _onSelected(type),
            ),
          )
          .toList(),
    );
  }

  void Function() _onSelected(type) => () => onUpdateHidden(
        !hidden.contains(type)
            ? {...hidden, type}
            : {...hidden.where((element) => element != type)},
      );
}
