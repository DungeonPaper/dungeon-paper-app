import 'dart:ui';

import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/controllers/ability_scores_form_controller.dart';
import 'package:dungeon_paper/app/modules/BasicInfoForm/controllers/basic_info_form_controller.dart';
import 'package:dungeon_paper/app/modules/ClassAlignments/controllers/class_alignments_controller.dart';
import 'package:dungeon_paper/app/modules/CreateCharacter/SelectMovesSpells/controllers/select_moves_spells_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/character_classes_library_list_view.dart';
import 'package:dungeon_paper/app/modules/StartingGearForm/controllers/starting_gear_form_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/dw_icons.dart';
import '../../../widgets/chips/advanced_chip.dart';
import '../controllers/create_character_controller.dart';

class CreateCharacterView extends StatelessWidget with CharacterProviderMixin {
  const CreateCharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateCharacterController.consumer(
      (context, controller, _) {
        final cls = controller.characterClass;
        return ConfirmExitView(
          dirty: controller.dirty,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            // blendMode: BlendMode.darken,
            child: Scaffold(
              backgroundColor: Colors.black.withOpacity(0.85),
              appBar: AppBar(
                title: Container(),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
              ),
              floatingActionButton: AdvancedFloatingActionButton.extended(
                onPressed: controller.isValid
                    ? () {
                        charProvider.createCharacter(
                          controller.getAsCharacter(),
                          switchToCharacter: true,
                        );
                        Navigator.of(context).pop();
                      }
                    : null,
                icon: const Icon(Icons.person_add),
                label: Text(
                  tr.generic.createEntity(tr.entity(tn(Character))),
                ),
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: SizedBox(
                      width: 340,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Basic Info
                              _Card(
                                leading: CharacterAvatar.squircle(
                                  size: 48,
                                  character: Character.empty().copyWith(
                                    avatarUrl: controller.avatarUrl,
                                  ),
                                ),
                                title: controller.name.isEmpty
                                    ? Text(
                                        tr.createCharacter.basicInfo
                                            .defaultName,
                                      )
                                    : Text(controller.name),
                                subtitle: controller.name.isEmpty
                                    ? Text(
                                        tr.createCharacter.basicInfo.helpText)
                                    : Text(
                                        tr.createCharacter.basicInfo
                                            .description(
                                          cls?.name ?? '',
                                        ),
                                      ),
                                valid: controller.name.isNotEmpty,
                                onTap: () => Navigator.of(context).pushNamed(
                                  Routes.createCharacterBasicInfo,
                                  arguments: BasicInfoFormArguments(
                                    avatarUrl: controller.avatarUrl,
                                    name: controller.name,
                                    onChanged: controller.setBasicInfo,
                                  ),
                                ),
                              ),
                              // Class
                              _Card(
                                title: cls == null
                                    ? Text(tr.generic.selectEntity(
                                        tr.entity(tn(CharacterClass))))
                                    : Text(cls.name),
                                subtitle: cls == null
                                    ? Text(tr.createCharacter.characterClass
                                        .noSelection)
                                    : Text(
                                        tr.createCharacter.characterClass
                                            .description(
                                          cls.hp,
                                          cls.load,
                                          cls.damageDice.toString(),
                                        ),
                                      ),
                                valid: cls != null,
                                onTap: () => Navigator.of(context).pushNamed(
                                  Routes.createCharacterSelectClass,
                                  arguments: CharacterClassLibraryListArguments(
                                    preSelections:
                                        controller.characterClass != null
                                            ? [controller.characterClass!]
                                            : [],
                                    onSelected: (cls) =>
                                        controller.setClass(context, cls),
                                  ),
                                ),
                              ),
                              // Race
                              _Card(
                                title: controller.race == null
                                    ? Text(tr.generic
                                        .selectEntity(tr.entity(tn(Race))))
                                    : Text(controller.race!.name),
                                subtitle: controller.race == null
                                    ? Text(tr.generic
                                        .noEntitySelected(tr.entity(tn(Race))))
                                    : Text(
                                        controller.race!.description,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                onTap: cls != null
                                    ? () => ModelPages.openRacesList(
                                          context,
                                          character:
                                              controller.getAsCharacter(),
                                          preSelection: controller.race,
                                          onSelected: (race) =>
                                              controller.race = race,
                                        )
                                    : null,
                                valid: controller.race != null,
                              ),
                              // Ability Scores
                              _Card(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                title: Text(tr.generic.selectEntity(
                                    tr.entityPlural(tn(AbilityScore)))),
                                // subtitle: Text(
                                //   controller.abilityScores.stats
                                //       .map((stat) => '${stat.key}: ${stat}')
                                //       .join(', '),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: _AbilityScoreChipList(
                                      controller: controller),
                                ),
                                onTap: () => Navigator.of(context).pushNamed(
                                  Routes.createCharacterAbilityScores,
                                  arguments: AbilityScoresFormArguments(
                                    onChanged: (abilityScores) => controller
                                        .setAbilityScores(abilityScores),
                                    abilityScores: controller.abilityScores,
                                  ),
                                ),
                              ),
                              // Alignment
                              _Card(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0),
                                valid: controller.alignment != null,
                                title: Text(
                                  controller.alignment != null
                                      ? [
                                          tr.entity(tn(AlignmentValue)),
                                          tr.alignment.name(
                                              controller.alignment!.type.name)
                                        ].join(': ')
                                      : tr.generic.selectEntity(
                                          tr.entity(tn(AlignmentValue)),
                                        ),
                                ),
                                subtitle: controller.alignment != null
                                    ? Text(
                                        controller.alignment!.description
                                                .isNotEmpty
                                            ? controller.alignment!.description
                                            : tr.generic.noDescription,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )
                                    : Text(
                                        tr.generic.noEntitySelectedRequired(
                                            tr.entity(tn(AlignmentValue))),
                                      ),
                                onTap: cls != null
                                    ? () => Navigator.of(context).pushNamed(
                                          Routes.classAlignments,
                                          arguments: ClassAlignmentsArguments(
                                            onChanged: controller.setAlignment,
                                            alignments: controller
                                                .characterClass!.alignments,
                                            preselected:
                                                controller.alignment?.type,
                                            selectable: true,
                                            editable: true,
                                          ),
                                        )
                                    : null,
                              ),

                              // Starting Gear
                              _Card(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                title: Text(
                                  tr.generic.selectEntity(
                                    tr.entity(tn(GearSelection)),
                                  ),
                                ),
                                subtitle: Text(controller.items.isEmpty &&
                                        controller.coins == 0
                                    ? tr.createCharacter.startingGear.helpText
                                    : [
                                        controller.coins > 0
                                            ? tr.createCharacter.startingGear
                                                .coins(
                                                NumberFormat('#0.#')
                                                    .format(controller.coins),
                                              )
                                            : null,
                                        controller.items
                                            .map((i) => tr.createCharacter
                                                    .startingGear
                                                    .item(
                                                  NumberFormat('#0.#')
                                                      .format(i.amount),
                                                  i.name,
                                                ))
                                            .join(', '),
                                      ].whereType<String>().join(', ')),
                                onTap: cls != null
                                    ? () => Navigator.of(context).pushNamed(
                                          Routes.createCharacterStartingGear,
                                          arguments: StartingGearFormArguments(
                                            onChanged:
                                                controller.setStartingGear,
                                            selectedOptions:
                                                controller.startingGear,
                                            characterClass: cls,
                                          ),
                                        )
                                    : null,
                                valid: cls == null
                                    ? false
                                    : cls.gearChoices.every(
                                        (c) => c.selections.any(
                                          (s) => controller.startingGear
                                              .map((x) => x.key)
                                              .contains(s.key),
                                        ),
                                      ),
                              ),
                              // Moves & Spells
                              _Card(
                                // contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                title: Text(
                                  tr.generic.selectEntity(
                                    (cls?.isSpellcaster ?? false)
                                        ? tr.createCharacter.movesSpells.title
                                        : tr.entityPlural(tn(Move)),
                                  ),
                                ),
                                subtitle: Text(
                                  (cls?.isSpellcaster ?? false)
                                      ? tr.createCharacter.movesSpells
                                          .description(
                                          controller.moves.length,
                                          controller.spells.length,
                                        )
                                      : tr.entityCountNum(
                                          tn(Move),
                                          controller.moves.length,
                                        ),
                                ),
                                onTap: cls != null
                                    ? () => Navigator.of(context).pushNamed(
                                          Routes.createCharacterMovesSpells,
                                          arguments: SelectMovesSpellsArguments(
                                            onChanged:
                                                controller.setMovesAndSpells,
                                            moves: controller.moves,
                                            spells: controller.spells,
                                            abilityScores:
                                                controller.abilityScores,
                                            characterClass:
                                                controller.characterClass!,
                                          ),
                                        )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AbilityScoreChipList extends StatelessWidget {
  const _AbilityScoreChipList({
    required this.controller,
  });

  final CreateCharacterController controller;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: controller.abilityScores.stats
          .map(
            (stat) => ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 90,
              ),
              child: AdvancedChip(
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                labelPadding:
                    // EdgeInsets.zero,
                    const EdgeInsets.only(right: 8),
                avatar: Icon(
                  DwIcons.statIcon(
                    stat.key.toLowerCase(),
                  ),
                  size: 12,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                label: Text(
                  '${stat.key}: ${stat.value}',
                  textScaler: const TextScaler.linear(0.8),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    this.contentPadding,
    this.leading,
    required this.title,
    required this.subtitle,
    this.valid = true,
    required this.onTap,
  });

  final EdgeInsets? contentPadding;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final bool valid;
  final GestureTapCallback? onTap;

  bool get isEnabled => onTap != null;

  @override
  Widget build(BuildContext context) {
    final cardColor = isEnabled
        ? valid
            ? DwColors.success
            : DwColors.warning
        : Theme.of(context).colorScheme.onSurface;
    return Card(
      elevation: 0,
      color: cardColor.withOpacity(0.2),
      child: ListTile(
        onTap: onTap,
        contentPadding: contentPadding,
        leading: leading,
        title: title != null
            ? DefaultTextStyle.merge(
                child: title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isEnabled ? null : Theme.of(context).disabledColor,
                ),
              )
            : null,
        subtitle: subtitle != null
            ? DefaultTextStyle.merge(
                child: subtitle!,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: isEnabled ? null : Theme.of(context).disabledColor,
                ),
              )
            : null,
        // trailing: isIncomplete ?  _MissingInfoIcon() : null,
      ),
    );
  }
}

