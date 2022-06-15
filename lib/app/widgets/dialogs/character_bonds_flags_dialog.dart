import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/modules/BondsFlagsForm/controllers/bonds_flags_form_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharacterBondsFlagsDialog extends GetView<CharacterService> with CharacterServiceMixin {
  const CharacterBondsFlagsDialog({Key? key}) : super(key: key);

  List<SessionMark> get bonds => char.bonds;
  List<SessionMark> get flags => char.flags;
  List<SessionMark> get sessionMarks => char.sessionMarks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Obx(
              () => Text(
                SessionMark.categoryTitle(bonds: bonds, flags: flags),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(
                Routes.bondsFlags,
                arguments: BondsFlagsFormArguments(
                  bonds: bonds,
                  flags: flags,
                  onChanged: (bonds, flags) => controller.updateCharacter(
                    character.copyWith(sessionMarks: [...bonds, ...flags]),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit, size: 20),
          )
        ],
      ),
      contentPadding: const EdgeInsets.all(16),
      actions: [
        ElevatedButton.icon(
          icon: const Icon(Icons.check),
          label: Text(S.current.done),
          onPressed: () => Get.back(),
          style: ButtonThemes.primaryElevated(context),
        )
      ],
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
                if (bonds.isEmpty && flags.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.translate(
                          offset: const Offset(0, 2),
                          child: Container(
                            child: Icon(
                              Icons.question_mark,
                              size: 12,
                              color: theme.cardColor,
                            ),
                            decoration: BoxDecoration(
                              color: textTheme.caption!.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            S.current.characterBondsFlagsDialogNoData,
                            style: textTheme.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (bonds.isNotEmpty && flags.isNotEmpty)
                  Text(S.current.characterBondsFlagsDialogBonds, style: textTheme.caption),
                for (final bond in bonds) ...[
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    onTap: () => controller.updateCharacter(
                      char.copyWith(
                        sessionMarks: sessionMarks
                            .map((e) => e.key == bond.key
                                ? e.copyWithInherited(completed: !bond.completed)
                                : e)
                            .toList(),
                      ),
                    ),
                    leading: Checkbox(
                      value: bond.completed,
                      onChanged: (val) => controller.updateCharacter(
                        char.copyWith(
                          sessionMarks: sessionMarks
                              .map((e) =>
                                  e.key == bond.key ? e.copyWithInherited(completed: val) : e)
                              .toList(),
                        ),
                      ),
                    ),
                    title: Text(bond.description),
                  ),
                ],
                if (bonds.isNotEmpty && flags.isNotEmpty)
                  Text(S.current.characterBondsFlagsDialogFlags, style: textTheme.caption),
                for (final flag in flags) ...[
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    onTap: () => controller.updateCharacter(
                      char.copyWith(
                        sessionMarks: sessionMarks
                            .map((e) => e.key == flag.key
                                ? e.copyWithInherited(completed: !flag.completed)
                                : e)
                            .toList(),
                      ),
                    ),
                    leading: Checkbox(
                      value: flag.completed,
                      onChanged: (val) => controller.updateCharacter(
                        char.copyWith(
                          sessionMarks: sessionMarks
                              .map((e) =>
                                  e.key == flag.key ? e.copyWithInherited(completed: val) : e)
                              .toList(),
                        ),
                      ),
                    ),
                    title: Text(flag.description),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
