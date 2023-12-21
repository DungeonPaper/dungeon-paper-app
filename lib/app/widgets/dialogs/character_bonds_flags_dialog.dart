import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/modules/BondsFlagsForm/controllers/bonds_flags_form_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class CharacterBondsFlagsDialog extends StatelessWidget
    with CharacterProviderMixin {
  const CharacterBondsFlagsDialog({super.key});

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
            child: CharacterProvider.consumer(
              (context, charProvider, _) => Text(
                SessionMark.categoryTitle(
                  bonds: charProvider.current.bonds,
                  flags: charProvider.current.flags,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                Routes.bondsFlags,
                arguments: BondsFlagsFormArguments(
                  bonds: charProvider.current.bonds,
                  flags: charProvider.current.flags,
                  onChanged: (bonds, flags) => charProvider.updateCharacter(
                    character.copyWithSessionMarks(
                      bonds: bonds,
                      flags: flags,
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit, size: 20),
          )
        ],
      ),
      contentPadding: const EdgeInsets.all(16),
      actions: DialogControls.done(context, () => Navigator.of(context).pop()),
      content: CharacterProvider.consumer(
        (context, charProvider, _) {
          final char = charProvider.current;
          return SingleChildScrollView(
            child: ListTileTheme.merge(
              minLeadingWidth: 20,
              contentPadding: const EdgeInsets.all(0),
              minVerticalPadding: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (char.bonds.isEmpty && char.flags.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: HelpText(
                        text: tr.sessionMarks.noData,
                      ),
                    ),
                  if (char.bonds.isNotEmpty || char.flags.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: HelpText(
                        text: tr.sessionMarks.info,
                      ),
                    ),
                    const Divider(height: 32),
                  ],
                  if (char.bonds.isNotEmpty && char.flags.isNotEmpty)
                    Text(tr.sessionMarks.bond, style: textTheme.bodySmall),
                  for (final bond in char.bonds) ...[
                    CheckboxListTile(
                      title: Text(bond.description),
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      value: bond.completed,
                      onChanged: (val) => onChecked(bond, val),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                  if (char.bonds.isNotEmpty && char.flags.isNotEmpty) ...[
                    const Divider(height: 32),
                    Text(tr.sessionMarks.flags, style: textTheme.bodySmall),
                  ],
                  for (final flag in char.flags) ...[
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
          );
        },
      ),
    );
  }

  Future<void> onChecked(SessionMark sessionMark, [bool? val]) {
    return charProvider.updateCharacter(
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
