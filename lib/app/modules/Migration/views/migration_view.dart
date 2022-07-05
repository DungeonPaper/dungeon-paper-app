import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/migration_controller.dart';

class MigrationView extends GetView<MigrationController> {
  const MigrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MigrationView'),
        centerTitle: true,
      ),
      floatingActionButton: Obx(
        () => AdvancedFloatingActionButton.extended(
          onPressed: controller.isValid ? controller.done : null,
          label: const Text('Continue'),
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
                Obx(
                  () => TextFormField(
                    controller: controller.username,
                    decoration: const InputDecoration(
                      // TODO intl
                      label: Text('Username'),
                      hintText: 'Pick a username',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => SelectBox(
                    value: controller.language,
                    // TODO intl
                    label: const Text('Default Data Language'),
                    items: const [
                      DropdownMenuItem(child: Text('EN'), value: 'EN'),
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
