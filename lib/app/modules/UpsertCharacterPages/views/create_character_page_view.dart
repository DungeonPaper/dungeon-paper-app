import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/character_information_view.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/select_character_class_view.dart';
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
        controller: controller.currentStep,
        children: [
          CharacterInformationView(
              onValidate: (valid) => controller.setValid(CreateCharStep.information, valid)),
          const SelectCharacterClassView(),
        ],
      ),
      bottomNavigationBar: Container(
        color: theme.scaffoldBackgroundColor,
        child: Row(
          children: [
            NavItem(
              icon: Icons.person,
              onTap: () => goToPage(0),
              disabled: false,
              valid: controller.isValid[CreateCharStep.information] ?? false,
            ),
            NavItem(
              icon: Icons.access_time, // TODO find char class icon
              onTap: () => goToPage(1),
              disabled: false,
              valid: controller.isValid[CreateCharStep.charClass] ?? false,
            ),
          ],
        ),
      ),
    );
  }

  void goToPage(int page) => controller.currentStep.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
}
