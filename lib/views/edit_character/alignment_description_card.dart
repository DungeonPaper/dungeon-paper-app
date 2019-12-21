import '../../utils.dart';
import '../../db/character_utils.dart' as Chr;
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:dungeon_world_data/alignment.dart' as DWA;

class AlignmentDescription extends StatelessWidget {
  final PlayerClass playerClass;
  final Chr.Alignment alignment;
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
    DWA.Alignment alignmentInfo = playerClass.alignments[alignmentKey] ??
        DWA.Alignment(key: alignmentKey, name: alignmentKey, description: '');
    bool hasDescription = alignmentInfo.description.isNotEmpty;

    List<Widget> texts = <Widget>[
      Text(
        capitalize(alignmentInfo.name),
        style: Theme.of(context).textTheme.title,
      ),
    ];
    if (hasDescription) {
      texts.add(Text(
        alignmentInfo.description,
        style: Theme.of(context).textTheme.body1,
      ));
    }
    return Material(
      color: Theme.of(context).canvasColor,
      elevation: 1.0,
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(5.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(icon, size: 40.0),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: texts,
                ),
              ),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  get icon => Chr.ALIGNMENT_ICON_MAP[alignment];
}
