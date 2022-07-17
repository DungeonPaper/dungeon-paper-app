import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/migration_controller.dart';

class MigrationView extends GetView<MigrationController> {
  const MigrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Obx(
        () => AdvancedFloatingActionButton.extended(
          onPressed: controller.isValid ? controller.done : null,
          label: Text(S.current.continueLabel),
          icon: const Icon(Icons.check),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TODO add some intro text, "Welcome to Dungeon Paper v2!"
                Obx(
                  () => TextFormField(
                    controller: controller.username,
                    decoration: InputDecoration(
                      label: Text(S.current.signupUsername),
                      hintText: S.current.signupUsernamePlaceholder,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => SelectBox(
                    value: controller.language,
                    label: Text(S.current.signupDefaultDataLanguage),
                    items: const [
                      DropdownMenuItem(child: Text('English'), value: 'EN'),
                    ],
                    onChanged: null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
