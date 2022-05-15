import 'dart:ui';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/app/modules/LibraryList/bindings/library_list_binding.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/character_classes_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/character_class_filters.dart';
import 'package:dungeon_paper/app/modules/BasicInfoForm/bindings/basic_info_form_binding.dart';
import 'package:dungeon_paper/app/modules/BasicInfoForm/views/basic_info_form_view.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/bindings/ability_scores_form_binding.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/views/ability_scores_form_view.dart';
import 'package:dungeon_paper/app/modules/StartingGearForm/bindings/starting_gear_form_binding.dart';
import 'package:dungeon_paper/app/modules/StartingGearForm/views/starting_gear_form_view.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../SelectMovesSpells/bindings/select_moves_spells_binding.dart';
import '../SelectMovesSpells/views/select_moves_spells_view.dart';
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
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 340),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _Card(
                            leading: CharacterAvatar.squircle(
                              size: 48,
                              character:
                                  Character.empty().copyWith(avatarUrl: controller.avatarUrl.value),
                            ),
                            // TODO intl
                            title: controller.name.isEmpty
                                ? const Text('Unnamed Traveler')
                                : Text(controller.name.value),
                            subtitle: controller.name.isEmpty
                                ? const Text('Select name & picture (required)')
                                : Text('Level 1 ${cls?.name ?? ''}'),
                            valid: controller.name.isNotEmpty,
                            onTap: () => Get.to(
                              () => BasicInfoFormView(
                                onChanged: controller.setBasicInfo,
                              ),
                              binding: BasicInfoFormBinding(
                                name: controller.name.value,
                                avatarUrl: controller.avatarUrl.value,
                              ),
                              preventDuplicates: false,
                            ),
                          ),
                          _Card(
                            // TODO intl
                            title: cls == null ? const Text('Select Class') : Text(cls!.name),
                            subtitle: cls == null
                                ? const Text('No class selected (required)')
                                : Text(
                                    'Base HP: ${cls!.hp}, Load: ${cls!.load}, Damage Dice: ${cls!.damageDice}'),
                            valid: cls != null,
                            onTap: () => Get.to(
                              () => const CharacterClassesLibraryListView(),
                              binding: LibraryListBinding(),
                              arguments:
                                  LibraryListArguments<CharacterClass, CharacterClassFilters>(
                                filters: {
                                  FiltersGroup.playbook: CharacterClassFilters(),
                                  FiltersGroup.my: CharacterClassFilters()
                                },
                                filterFn: (cls, filters) => filters.filter(cls),
                                sortFn: CharacterClass.sorter,
                                preSelections: controller.characterClass.value != null
                                    ? [controller.characterClass.value!]
                                    : [],
                                onAdd: (cls) => controller.setClass(cls.first),
                                extraData: const {},
                                multiple: false,
                              ),
                              preventDuplicates: false,
                            ),
                          ),
                          _Card(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            // TODO intl
                            title: const Text('Select Ability Scores'),
                            subtitle: Text(
                              controller.abilityScores.value.stats
                                  .map((stat) => '${stat.key}: ${stat.value}')
                                  .join(', '),
                            ),
                            onTap: () => Get.to(
                              () => AbilityScoresFormView(
                                onChanged: (abilityScores) =>
                                    controller.setAbilityScores(abilityScores),
                              ),
                              binding: AbilityScoresFormBinding(
                                  abilityScores: controller.abilityScores.value),
                              preventDuplicates: false,
                            ),
                          ),
                          _Card(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            // TODO intl
                            title: const Text('Select Starting Gear'),
                            subtitle: Text(controller.items.isEmpty && controller.coins == 0
                                ? 'Select your starting gear determined by class (optional)'
                                : [
                                    controller.coins > 0
                                        ? NumberFormat('#0.#').format(controller.coins) + ' coins'
                                        : null,
                                    controller.items
                                        .map((i) =>
                                            '${NumberFormat('#0.#').format(i.amount)} × ${i.name}')
                                        .join(', '),
                                  ].whereType<String>().join(', ')),
                            onTap: cls != null
                                ? () => Get.to(
                                      () => StartingGearFormView(
                                        onChanged: controller.setStartingGear,
                                      ),
                                      binding: StartingGearFormBinding(
                                        selections: controller.startingGear,
                                        characterClass: cls!,
                                      ),
                                      preventDuplicates: false,
                                    )
                                : null,
                            valid: cls == null
                                ? false
                                : cls!.gearChoices.every(
                                    (c) => c.selections.any(
                                      (s) => controller.startingGear.map(keyFor).contains(s.key),
                                    ),
                                  ),
                          ),
                          _Card(
                            // contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            // TODO intl
                            title: const Text('Select Moves & Spells'),
                            subtitle: Text(
                                '${controller.moves.length} Moves, ${controller.spells.length} Spells selected'),
                            onTap: cls != null
                                ? () => Get.to(
                                      () => SelectMovesSpellsView(
                                        onChanged: controller.setMovesSpells,
                                      ),
                                      binding: SelectMovesSpellsBinding(
                                        moves: controller.moves,
                                        spells: controller.spells,
                                        abilityScores: controller.abilityScores.value,
                                        characterClass: controller.characterClass.value!,
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
    return Card(
      elevation: 0,
      color: (isEnabled
              ? valid
                  ? DwColors.success
                  : DwColors.warning
              : Theme.of(context).colorScheme.onSurface)
          .withOpacity(0.2),
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
