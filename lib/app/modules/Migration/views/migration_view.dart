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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
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
            padding: const EdgeInsets.all(8).copyWith(bottom: 96),
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.current.migrationTitle,
                    style: textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.current.migrationSubtitle,
                    style: textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => TextFormField(
                      controller: controller.username,
                      decoration: InputDecoration(
                        label: Text(S.current.signupUsername),
                        hintText: S.current.signupUsernamePlaceholder,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(S.current.migrationUsernameInfo, style: textTheme.bodySmall),
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
      ),
    );
  }
}
