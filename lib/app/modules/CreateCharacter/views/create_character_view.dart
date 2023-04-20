import 'dart:ui';

import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
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
import 'package:dungeon_paper/app/widgets/chips/tag_chip.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/dw_icons.dart';
import '../../../widgets/chips/advanced_chip.dart';
import '../controllers/create_character_controller.dart';

class CreateCharacterView extends GetView<CreateCharacterController> {
  const CreateCharacterView({Key? key}) : super(key: key);

  CharacterClass? get cls => controller.characterClass.value;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
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
            floatingActionButton: Obx(
              () => AdvancedFloatingActionButton.extended(
                onPressed: controller.isValid
                    ? () {
                        Get.find<CharacterService>().createCharacter(
                          controller.getAsCharacter(),
                          switchToCharacter: true,
                        );
                        Get.back();
                      }
                    : null,
                icon: const Icon(Icons.person_add),
                label: Text(
                  S.current.createGeneric(Character),
                ),
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
                                    avatarUrl: controller.avatarUrl.value),
                              ),
                              title: controller.name.isEmpty
                                  ? Text(S
                                      .current.createCharacterTravelerBlankName)
                                  : Text(controller.name.value),
                              subtitle: controller.name.isEmpty
                                  ? Text(
                                      S.current.createCharacterTravelerHelpText)
                                  : Text(
                                      S.current
                                          .createCharacterTravelerDescription(
                                              cls?.name ?? ''),
                                    ),
                              valid: controller.name.isNotEmpty,
                              onTap: () => Get.toNamed(
                                Routes.createCharacterBasicInfo,
                                arguments: BasicInfoFormArguments(
                                  avatarUrl: controller.avatarUrl.value,
                                  name: controller.name.value,
                                  onChanged: controller.setBasicInfo,
                                ),
                                preventDuplicates: false,
                              ),
                            ),
                            // Class
                            _Card(
                              title: cls == null
                                  ? Text(S.current.selectGeneric(
                                      S.current.entity(CharacterClass)))
                                  : Text(cls!.name),
                              subtitle: cls == null
                                  ? Text(S.current.createCharacterClassHelpText)
                                  : Text(
                                      S.current.createCharacterClassDescription(
                                          cls!.hp, cls!.load, cls!.damageDice),
                                    ),
                              valid: cls != null,
                              onTap: () => Get.toNamed(
                                Routes.createCharacterSelectClass,
                                arguments: CharacterClassLibraryListArguments(
                                  preSelections:
                                      controller.characterClass.value != null
                                          ? [controller.characterClass.value!]
                                          : [],
                                  onSelected: (cls) => controller.setClass(cls),
                                ),
                                preventDuplicates: false,
                              ),
                            ),
                            // Race
                            _Card(
                              title: controller.race.value == null
                                  ? Text(S.current
                                      .selectGeneric(S.current.entity(Race)))
                                  : Text(controller.race.value!.name),
                              subtitle: controller.race.value == null
                                  ? Text(S.current.errorNoSelectionGeneric(
                                      S.current.entity(Race)))
                                  : Text(
                                      controller.race.value!.description,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              onTap: cls != null
                                  ? () => ModelPages.openRacesList(
                                        character: controller.getAsCharacter(),
                                        preSelection: controller.race.value,
                                        onSelected: (race) =>
                                            controller.race.value = race,
                                      )
                                  : null,
                              valid: controller.race.value != null,
                            ),
                            // Ability Scores
                            _Card(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              title: Text(S.current.selectGeneric(
                                  S.current.entityPlural(AbilityScore))),
                              // subtitle: Text(
                              //   controller.abilityScores.value.stats
                              //       .map((stat) => '${stat.key}: ${stat.value}')
                              //       .join(', '),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: _AbilityScoreChipList(
                                    controller: controller),
                              ),
                              onTap: () => Get.toNamed(
                                Routes.createCharacterAbilityScores,
                                arguments: AbilityScoresFormArguments(
                                  onChanged: (abilityScores) => controller
                                      .setAbilityScores(abilityScores),
                                  abilityScores: controller.abilityScores.value,
                                ),
                                preventDuplicates: false,
                              ),
                            ),
                            // Alignment
                            _Card(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              valid: controller.alignment.value != null,
                              title: Text(controller.alignment.value != null
                                  ? S.current.entity(AlignmentValue) +
                                      ': ' +
                                      S.current.alignment(
                                          controller.alignment.value!.type)
                                  : S.current.selectGeneric(
                                      S.current.entity(AlignmentValue))),
                              subtitle: controller.alignment.value != null
                                  ? Text(
                                      controller.alignment.value!.description
                                              .isNotEmpty
                                          ? controller
                                              .alignment.value!.description
                                          : S.current.noDescription,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    )
                                  : Text(
                                      S.current.errorNoSelectionGenericRequired(
                                          S.current.entity(AlignmentValue)),
                                    ),
                              onTap: cls != null
                                  ? () => Get.toNamed(
                                        Routes.classAlignments,
                                        arguments: ClassAlignmentsArguments(
                                          onChanged: controller.setAlignment,
                                          alignments: controller
                                              .characterClass.value!.alignments,
                                          preselected:
                                              controller.alignment.value?.type,
                                          selectable: true,
                                          editable: true,
                                        ),
                                        preventDuplicates: false,
                                      )
                                  : null,
                            ),

                            // Starting Gear
                            _Card(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              title: Text(S.current.selectGeneric(
                                  S.current.entity(GearSelection))),
                              subtitle: Text(controller.items.isEmpty &&
                                      controller.coins == 0
                                  ? S.current
                                      .createCharacterStartingGearHelpText
                                  : [
                                      controller.coins > 0
                                          ? S.current
                                              .createCharacterStartingGearDescriptionCoins(
                                              NumberFormat('#0.#')
                                                  .format(controller.coins),
                                            )
                                          : null,
                                      controller.items
                                          .map((i) => S.current
                                                  .createCharacterStartingGearDescriptionItem(
                                                NumberFormat('#0.#')
                                                    .format(i.amount),
                                                i.name,
                                              ))
                                          .join(', '),
                                    ].whereType<String>().join(', ')),
                              onTap: cls != null
                                  ? () => Get.toNamed(
                                        Routes.createCharacterStartingGear,
                                        arguments: StartingGearFormArguments(
                                          onChanged: controller.setStartingGear,
                                          selectedOptions:
                                              controller.startingGear,
                                          characterClass: cls!,
                                        ),
                                        preventDuplicates: false,
                                      )
                                  : null,
                              valid: cls == null
                                  ? false
                                  : cls!.gearChoices.every(
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
                                S.current.selectGeneric(
                                  (cls?.isSpellcaster ?? false)
                                      ? S.current.createCharacterMovesSpells
                                      : S.current.entityPlural(Move),
                                ),
                              ),
                              subtitle: Text(
                                (cls?.isSpellcaster ?? false)
                                    ? S.current
                                        .createCharacterMovesSpellsDescription(
                                        controller.moves.length,
                                        controller.spells.length,
                                      )
                                    : S.current.movesWithCount(
                                        controller.moves.length),
                              ),
                              onTap: cls != null
                                  ? () => Get.toNamed(
                                        Routes.createCharacterMovesSpells,
                                        arguments: SelectMovesSpellsArguments(
                                          onChanged: controller.setMovesSpells,
                                          moves: controller.moves,
                                          spells: controller.spells,
                                          abilityScores:
                                              controller.abilityScores.value,
                                          characterClass:
                                              controller.characterClass.value!,
                                        ),
                                        preventDuplicates: false,
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
      ),
    );
  }
}

class _AbilityScoreChipList extends StatelessWidget {
  const _AbilityScoreChipList({
    super.key,
    required this.controller,
  });

  final CreateCharacterController controller;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: controller.abilityScores.value.stats
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
                  textScaleFactor: 0.8,
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
    Key? key,
    this.contentPadding,
    this.leading,
    required this.title,
    required this.subtitle,
    this.valid = true,
    required this.onTap,
  }) : super(key: key);

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
