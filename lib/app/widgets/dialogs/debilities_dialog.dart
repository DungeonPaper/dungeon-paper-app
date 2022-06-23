import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharacterDebilitiesDialog extends GetView<CharacterService> with CharacterServiceMixin {
  const CharacterDebilitiesDialog({Key? key}) : super(key: key);

  List<SessionMark> get bonds => char.bonds;
  List<SessionMark> get flags => char.flags;
  List<SessionMark> get sessionMarks => char.sessionMarks;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(S.current.characterDebilitiesDialogTitle),
      contentPadding: const EdgeInsets.all(16),
      actions: DialogControls.done(context, () => Get.back()),
      content: Obx(
        () => SingleChildScrollView(
          child: ListTileTheme.merge(
            minLeadingWidth: 20,
            contentPadding: const EdgeInsets.all(0),
            minVerticalPadding: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final ability in char.abilityScores.stats)
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(S.current.debilityLabel(ability.debilityName, ability.key)),
                    subtitle: Text(ability.debilityDescription),
                    dense: true,
                    onTap: () => charService.updateCharacter(
                      char.copyWith(
                        abilityScores: char.abilityScores.copyWith(
                          stats: char.abilityScores.stats.map(
                            (e) => e.key == ability.key
                                ? e.copyWith(isDebilitated: !e.isDebilitated)
                                : e,
                          ),
                        ),
                      ),
                    ),
                    trailing: Switch.adaptive(
                      value: ability.isDebilitated,
                      onChanged: (checked) => charService.updateCharacter(
                        char.copyWith(
                          abilityScores: char.abilityScores.copyWith(
                            stats: char.abilityScores.stats.map((e) =>
                                e.key == ability.key ? e.copyWith(isDebilitated: checked) : e),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
