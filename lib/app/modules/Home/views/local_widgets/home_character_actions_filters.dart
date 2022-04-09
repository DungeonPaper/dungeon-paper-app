import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeCharacterActionsFiltersView extends StatelessWidget {
  const HomeCharacterActionsFiltersView({
    Key? key,
    required this.hidden,
    required this.onUpdateHidden,
  }) : super(key: key);

  final Set<String> hidden;
  final void Function(Set<String> filters) onUpdateHidden;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: <Widget>[
            Text(S.current.actionsViewVisibleLabel),
            const SizedBox(width: 8),
          ] +
          [
            'Move',
            'Spell',
            'Item',
          ]
              .map((type) => FilterChip(
                    label: Text(S.current.entityPlural(type)),
                    selected: !hidden.contains(type),
                    onSelected: (show) => onUpdateHidden(!show
                        ? {...hidden, type}
                        : {...hidden.where((element) => element != type)}),
                  ))
              .toList(),
    );
  }
}
