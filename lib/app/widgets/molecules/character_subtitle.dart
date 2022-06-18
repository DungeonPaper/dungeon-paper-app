import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class CharacterSubtitle extends StatelessWidget {
  const CharacterSubtitle({
    Key? key,
    required this.character,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  final Character character;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyText2,
        children: <InlineSpan>[
          TextSpan(text: S.current.characterHeaderSubtitleLevel(character.stats.level)),
          TextSpan(text: S.current.characterHeaderSubtitleClass(character.characterClass.name)),
          TextSpan(text: S.current.characterHeaderSubtitleRace(character.race.name)),
          TextSpan(
            children: [
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(0, -2),
                  child: Text(
                    String.fromCharCode(character.bio.alignment.icon.codePoint),
                    style: DefaultTextStyle.of(context).style.copyWith(
                          fontFamily: character.bio.alignment.icon.fontFamily,
                        ),
                  ),
                ),
              ),
              TextSpan(
                text: ' ' +
                    S.current.characterHeaderSubtitleAlignment(
                      S.current.alignment(character.bio.alignment.type),
                    ),
              ),
            ],
          ),
        ]
            .joinObjects(
              TextSpan(text: S.current.characterHeaderSubtitleSeparator),
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
    //       S.current.characterHeaderSubtitle(
    //         character.stats.level,
    //         character.characterClass.name,
    //         character.race.name,
    //         // "test",
    //         // char.bio.toRawJson() ?? 'test',
    //         // S.current.alignment(char.bio.alignment.key),
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
    //           // S.current.characterHeaderSubtitle(
    //           //   char.stats.level,
    //           //   char.characterClass.name,
    //           // "test",
    //           // char.bio.toRawJson() ?? 'test',
    //           S.current.alignment(character.bio.alignment.key),
    //           // ),
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
