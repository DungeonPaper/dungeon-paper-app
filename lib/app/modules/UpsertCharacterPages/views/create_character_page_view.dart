import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_class_select_view.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_information_view.dart';
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
      body: PageView(
        controller: controller.pageController.value,
        children: [
          CharacterInformationView(
            onValidate: (valid, info) =>
                controller.setValid(CreateCharStep.information, valid, info),
          ),
          CharacterClassSelectView(
            onValidate: (valid, cls) => controller.setValid(CreateCharStep.charClass, valid, cls),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: controller.canProceed ? DwColors.success : Colors.grey,
          onPressed: controller.canProceed ? () => controller.proceed() : null,
          child: const Icon(Icons.arrow_forward),
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          return Container(
            color: theme.scaffoldBackgroundColor,
            child: Row(
              children: [
                NavItem(
                  icon: const Icon(Icons.person),
                  onTap: () => goToPage(0),
                  disabled: false,
                  valid: controller.isValid[CreateCharStep.information] ?? false,
                  active: controller.pageController.value.page == null ||
                      controller.pageController.value.page?.round() == 0,
                ),
                NavItem(
                  icon: const Icon(Icons.access_time), // TODO find char class icon
                  onTap: () => goToPage(1),
                  disabled: controller.lastAvailablePage.value < 1,
                  valid: controller.isValid[CreateCharStep.charClass] ?? false,
                  active: controller.pageController.value.page?.round() == 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void goToPage(int page) => controller.goToPage(page);
}
