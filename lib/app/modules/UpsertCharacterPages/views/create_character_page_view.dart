import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_class_select_view.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_gear_view.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_info_view.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_moves_spells_view.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_roll_stats_view.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../controllers/create_character_page_controller.dart';
import 'character_background_view.dart';
import 'local_widgets/nav_item.dart';

class CreateCharacterPageView extends GetView<CreateCharacterPageController> {
  const CreateCharacterPageView({Key? key}) : super(key: key);

  int get stepCount => CreateCharStep.values.length;
  List<CreateCharStep> get steps => CreateCharStep.values.toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.createCharacterTitle),
        centerTitle: true,
      ),
      body: Obx(
        () => PageView(
          controller: controller.pageController.value,
          children: [
            CharacterInfoView(
              onValidate: (valid, info) =>
                  controller.setValid(CreateCharStep.information, valid, info),
            ),
            CharacterBackgroundView(
              onValidate: (valid, background) =>
                  controller.setValid(CreateCharStep.background, valid, background),
            ),
            CharacterClassSelectView(
              onValidate: (valid, cls) => controller.setValid(CreateCharStep.charClass, valid, cls),
            ),
            CharacterGearView(
              onValidate: (valid, background) =>
                  controller.setValid(CreateCharStep.background, valid, background),
            ),
            CharacterRollStatsView(
              onValidate: (valid, stats) => controller.setValid(CreateCharStep.stats, valid, stats),
            ),
            CharacterMovesSpellsView(
              onValidate: (valid, movesSpells) =>
                  controller.setValid(CreateCharStep.movesSpells, valid, movesSpells),
            ),
          ].sublist(
              0, clamp(controller.lastAvailablePage.value + 1, 0, CreateCharStep.values.length)),
        ),
      ),
      floatingActionButton: Obx(
        () => !controller.allStepsDone
            ? FloatingActionButton(
                backgroundColor:
                    controller.canProceed ? DwColors.success : Theme.of(context).disabledColor,
                onPressed: controller.canProceed ? () => controller.proceed(context) : null,
                tooltip: S.current.createCharacterProceedTooltip,
                child: const Icon(Icons.arrow_forward),
              )
            : FloatingActionButton.extended(
                backgroundColor:
                    controller.canProceed ? DwColors.success : Theme.of(context).disabledColor,
                onPressed: () => controller.openPreview(context),
                tooltip: !controller.isLastStep ? S.current.createCharacterProceedTooltip : null,
                label: Text(S.current.createCharacterFinishButton),
                icon: const Icon(Icons.arrow_forward),
              ),
      ),
      bottomNavigationBar: Obx(
        () {
          return Material(
            color: theme.scaffoldBackgroundColor,
            elevation: 1,
            child: Row(
              children: navItems
                  .map(
                    (item) => NavItem(
                      icon: item.icon,
                      onTap: () => goToPage(CreateCharStep.values.indexOf(item.step)),
                      disabled:
                          controller.lastAvailablePage < CreateCharStep.values.indexOf(item.step),
                      valid: controller.isValid[item.step] ?? false,
                      active: controller.step == item.step,
                      tooltip: controller.isValid[item.step] == true ||
                              controller.lastAvailablePage <
                                  CreateCharStep.values.indexOf(item.step)
                          ? S.current.createCharacterStep(item.step.name)
                          : S.current.createCharacterStepInvalidTooltip(
                              S.current.createCharacterStep(item.step.name),
                            ),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  static const navItems = <NavItemData>[
    NavItemData(icon: Icon(Icons.person), step: CreateCharStep.information),
    NavItemData(icon: Icon(Icons.fireplace_outlined), step: CreateCharStep.background),
    NavItemData(icon: Icon(Icons.access_time), step: CreateCharStep.charClass),
    NavItemData(icon: Icon(Icons.personal_injury_rounded), step: CreateCharStep.gear),
    NavItemData(icon: Icon(Icons.list_alt_rounded), step: CreateCharStep.stats),
    NavItemData(icon: Icon(Icons.handshake), step: CreateCharStep.movesSpells),
  ];

  void goToPage(int page) => controller.goToPage(page);
}
