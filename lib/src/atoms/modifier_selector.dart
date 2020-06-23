import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/utils/types.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';

class ModifierSelector extends StatelessWidget {
  final VoidCallbackDelegate<int> onChanged;
  final int value;
  final TextStyle textStyle;
  final Character character;

  static const MAX_NUM = 4;

  const ModifierSelector({
    Key key,
    @required this.value,
    this.character,
    this.onChanged,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var options = List.generate(MAX_NUM * 2 + 1, (idx) => -MAX_NUM + idx);
    var normalText =
        textStyle.copyWith(color: Theme.of(context).colorScheme.onSurface);
    var modText = textStyle.copyWith(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
        fontSize: normalText.fontSize * 0.5);
    var emptyText = textStyle.copyWith(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
        fontSize: normalText.fontSize * 0.75);
    return Container(
      width: 70,
      child: DropdownButton(
        isExpanded: true,
        value: value,
        selectedItemBuilder: (context) => [
          for (var n in options)
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                n == 0 ? 'MOD' : (n > 0 ? '+' : '') + n.toString(),
                style: n == 0 ? emptyText : normalText,
              ),
            ),
        ],
        items: [
          for (var n in options)
            DropdownMenuItem(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (n > 0 ? '+' : '') + n.toString(),
                      style: normalText,
                    ),
                    if (_getModifiersForValue(n).isNotEmpty)
                      Text(
                        '(' + _getModifiersForValue(n).join(', ') + ')',
                        style: modText,
                      ),
                  ],
                ),
              ),
              value: n,
            )
        ],
        onChanged: onChanged,
      ),
    );
  }

  List<String> _getModifiersForValue(int n) {
    if (character == null) {
      return [];
    }
    var vals = {
      'STR': character.strMod,
      'DEX': character.dexMod,
      'CON': character.conMod,
      'WIS': character.wisMod,
      'INT': character.intMod,
      'CHA': character.chaMod,
    };

    return vals.keys.where((k) => vals[k] == n).toList();
  }
}
