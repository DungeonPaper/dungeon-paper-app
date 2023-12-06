import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/widgets/atoms/icon_span.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class CharacterSubtitle extends StatelessWidget {
  const CharacterSubtitle({
    super.key,
    required this.character,
    this.textAlign = TextAlign.center,
  });

  final Character character;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: <InlineSpan>[
          TextSpan(text: tr.character.header.level(character.stats.level)),
          TextSpan(
              text: tr.character.header
                  .characterClass(character.characterClass.name)),
          TextSpan(text: tr.character.header.race(character.race.name)),
          TextSpan(
            children: [
              IconSpan(
                context,
                icon: character.bio.alignment.icon,
              ),
              TextSpan(
                // ignore: prefer_interpolation_to_compose_strings
                text: ' ' +
                    tr.character.header.alignment(
                      tr.alignment.name(character.bio.alignment.key),
                    ),
              ),
            ],
          ),
        ]
            .joinObjects(
              TextSpan(text: tr.character.header.separator),
            )
            .toList(),
      ),
    );
    // return Wrap(
    //   alignment: wrapAlignment,
    //   runAlignment: TextAlign.start,
    //   spacing: 4,
    //   children: [
    //     Text(
    //       tr.character.header.(
    //         character.stats.level,
    //         character.characterClass.name,
    //         character.race.name,
    //         // "test",
    //         // char.bio.toRawJson() ?? 'test',
    //         // tr.alignment.name(char.bio.alignment.key),
    //       ),
    //     ),
    //     Row(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         IconTheme.merge(
    //           data: const IconThemeData(size: 14),
    //           child: character.bio.alignment.icon,
    //         ),
    //         const SizedBox(width: 4),
    //         Text(
    //           // tr.character.header.(
    //           //   char.stats.level,
    //           //   char.characterClass.name,
    //           // "test",
    //           // char.bio.toRawJson() ?? 'test',
    //           tr.alignment.name(character.bio.alignment.key),
    //           // ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}

