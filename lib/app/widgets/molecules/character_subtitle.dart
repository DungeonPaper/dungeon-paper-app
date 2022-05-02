import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class CharacterSubtitle extends StatelessWidget {
  const CharacterSubtitle({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
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
        Transform.translate(
          offset: const Offset(0, 2.5),
          child: IconTheme.merge(
            data: const IconThemeData(size: 14),
            child: character.bio.alignment.icon,
          ),
        ),
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
    );
  }
}
