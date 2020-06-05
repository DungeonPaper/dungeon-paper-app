import 'package:dungeon_paper/db/helpers/character_utils.dart' as chr;
import 'package:dungeon_paper/src/atoms/card_list_item.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:dungeon_world_data/alignment.dart' as dw;

class AlignmentDescription extends StatelessWidget {
  final PlayerClass playerClass;
  final chr.AlignmentName alignment;
  final VoidCallback onTap;
  final int level;

  const AlignmentDescription({
    Key key,
    @required this.playerClass,
    @required this.alignment,
    this.level,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String alignmentKey = enumName(alignment);
    dw.Alignment alignmentInfo = playerClass.alignments[alignmentKey] ??
        dw.Alignment(key: alignmentKey, name: alignmentKey, description: '');
    bool hasDescription = alignmentInfo.description.isNotEmpty;

    List<Widget> texts = <Widget>[
      Text(
        capitalize(alignmentInfo.name),
        style: Theme.of(context).textTheme.headline6,
      ),
    ];
    if (hasDescription) {
      texts.add(Text(
        alignmentInfo.description,
        style: Theme.of(context).textTheme.bodyText2,
      ));
    }
    return CardListItem(
      leading: Icon(icon, size: 40.0),
      trailing: onTap != null ? Icon(Icons.chevron_right) : null,
      title: Text(capitalize(alignmentInfo.name)),
      subtitle: alignmentInfo.description != null
          ? Text(alignmentInfo.description)
          : null,
      onTap: onTap,
    );
  }

  get icon => chr.ALIGNMENT_ICON_MAP[alignment];
}
