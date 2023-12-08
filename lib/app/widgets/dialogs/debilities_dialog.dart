import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharacterDebilitiesDialog extends GetView<CharacterService> with CharacterServiceMixin {
  const CharacterDebilitiesDialog({super.key});

  List<SessionMark> get bonds => char.bonds;
  List<SessionMark> get flags => char.flags;
  List<SessionMark> get sessionMarks => char.sessionMarks;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(tr.debilities.dialog.title),
      contentPadding: const EdgeInsets.all(16),
      actions: DialogControls.done(context, () => Get.back()),
      content: Obx(
        () => SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: ListTileTheme.merge(
              minLeadingWidth: 20,
              contentPadding: const EdgeInsets.all(0),
              minVerticalPadding: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HelpText(text: tr.debilities.dialog.info),
                  const SizedBox(height: 6),
                  const Divider(),
                  for (final ability in char.abilityScores.stats)
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(tr.debilities.label(ability.debilityName, ability.key)),
                      subtitle: Text(ability.debilityDescription),
                      dense: true,
                      leading: Icon(ability.icon, size: 20),
                      onTap: () => charService.updateCharacter(
                        char.copyWith(
                          abilityScores: char.abilityScores.copyWith(
                            stats: char.abilityScores.stats.map(
                              (e) => e.key == ability.key ? e.copyWith(isDebilitated: !e.isDebilitated) : e,
                            ),
                          ),
                        ),
                      ),
                      trailing: Switch.adaptive(
                        value: ability.isDebilitated,
                        onChanged: (checked) => charService.updateCharacter(
                          char.copyWith(
                            abilityScores: char.abilityScores.copyWith(
                              stats: char.abilityScores.stats
                                  .map((e) => e.key == ability.key ? e.copyWith(isDebilitated: checked) : e),
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
      ),
    );
  }
}
