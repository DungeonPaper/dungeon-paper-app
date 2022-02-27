import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_class_select_view.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_info_view.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_moves_spells_view.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_roll_stats_view.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../controllers/create_character_page_controller.dart';
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
            CharacterClassSelectView(
              onValidate: (valid, cls) => controller.setValid(CreateCharStep.charClass, valid, cls),
            ),
            CharacterRollStatsView(
              onValidate: (valid, stats) => controller.setValid(CreateCharStep.stats, valid, stats),
            ),
            CharacterMovesSpellsView(
              onValidate: (valid, stats) => controller.setValid(CreateCharStep.stats, valid, stats),
            ),
          ].sublist(0, controller.lastAvailablePage.value + 1),
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: controller.canProceed ? DwColors.success : Colors.grey,
          onPressed: controller.canProceed ? () => controller.proceed(context) : null,
          child: const Icon(Icons.arrow_forward),
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
    NavItemData(icon: Icon(Icons.access_time), step: CreateCharStep.charClass),
    NavItemData(icon: Icon(Icons.list_alt_rounded), step: CreateCharStep.stats),
  ];

  void goToPage(int page) => controller.goToPage(page);
}
