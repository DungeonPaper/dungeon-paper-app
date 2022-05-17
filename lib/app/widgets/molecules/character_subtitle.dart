import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class CharacterSubtitle extends StatelessWidget {
  const CharacterSubtitle({
    Key? key,
    required this.character,
    this.wrapAlignment = WrapAlignment.center,
  }) : super(key: key);

  final Character character;
  final WrapAlignment wrapAlignment;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: wrapAlignment,
      runAlignment: WrapAlignment.start,
      spacing: 4,
      children: [
        Text(
          S.current.characterHeaderSubtitle(
            character.stats.level,
            character.characterClass.name,
            character.race.name,
            // "test",
            // char.bio.toRawJson() ?? 'test',
            // S.current.alignment(char.bio.alignment.key),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconTheme.merge(
              data: const IconThemeData(size: 14),
              child: character.bio.alignment.icon,
            ),
            const SizedBox(width: 4),
            Text(
              // S.current.characterHeaderSubtitle(
              //   char.stats.level,
              //   char.characterClass.name,
              // "test",
              // char.bio.toRawJson() ?? 'test',
              S.current.alignment(character.bio.alignment.key),
              // ),
            ),
          ],
        ),
      ],
    );
  }
}
