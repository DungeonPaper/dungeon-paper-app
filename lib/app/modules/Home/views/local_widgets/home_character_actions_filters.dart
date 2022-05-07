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
    return PopupMenuButton<String>(
      icon: const Icon(Icons.filter_list_alt),
      onSelected: (type) => onUpdateHidden(
        !hidden.contains(type)
            ? {...hidden, type}
            : {...hidden.where((element) => element != type)},
      ),
      itemBuilder: (context) => ['Move', 'Spell', 'Item']
          .map(
            (type) => PopupMenuItem<String>(
              value: type,
              child: Row(
                children: [
                  SizedBox(
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
                  const SizedBox(width: 8),
                  Expanded(child: Text(S.current.entityPlural(type))),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
