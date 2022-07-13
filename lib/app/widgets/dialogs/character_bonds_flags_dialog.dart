import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/modules/BondsFlagsForm/controllers/bonds_flags_form_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
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
                    character
                        .copyWith(sessionMarks: [...bonds, ...flags, ...char.endOfSessionMarks]),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit, size: 20),
          )
        ],
      ),
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
                if (bonds.isEmpty && flags.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: HelpText(
                      text: S.current.characterBondsFlagsDialogNoData,
                    ),
                  ),
                if (bonds.isNotEmpty && flags.isNotEmpty)
                  Text(S.current.characterBondsFlagsDialogBonds, style: textTheme.caption),
                for (final bond in bonds) ...[
                  CheckboxListTile(
                    title: Text(bond.description),
                    visualDensity: VisualDensity.compact,
                    dense: true,
                    value: bond.completed,
                    onChanged: (val) => onChecked(bond, val),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
                if (bonds.isNotEmpty && flags.isNotEmpty)
                  Text(S.current.characterBondsFlagsDialogFlags, style: textTheme.caption),
                for (final flag in flags) ...[
                  CheckboxListTile(
                    title: Text(flag.description),
                    visualDensity: VisualDensity.compact,
                    dense: true,
                    value: flag.completed,
                    onChanged: (val) => onChecked(flag, val),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onChecked(SessionMark sessionMark, [bool? val]) {
    return controller.updateCharacter(
      char.copyWith(
        sessionMarks: updateByKey(
          sessionMarks,
          [
            sessionMark.copyWithInherited(
              completed: val ?? !sessionMark.completed,
            )
          ],
        ),
      ),
    );
  }
}
