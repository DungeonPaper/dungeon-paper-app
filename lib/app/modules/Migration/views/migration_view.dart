import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/migration_controller.dart';

class MigrationView extends StatelessWidget {
  const MigrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Consumer<MigrationController>(
      builder: (context, controller, _) => Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        floatingActionButton: AdvancedFloatingActionButton.extended(
          onPressed: controller.isValid ? () => controller.done(context) : null,
          label: Text(tr.generic.continue_),
          icon: const Icon(Icons.check),
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
                      tr.migration.title,
                      style: textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tr.migration.subtitle,
                      style: textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: controller.username,
                      decoration: InputDecoration(
                        label: Text(tr.migration.username.label),
                        hintText: tr.migration.username.placeholder,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(tr.migration.username.info,
                        style: textTheme.bodySmall),
                    const SizedBox(height: 16),
                    SelectBox(
                      value: controller.language,
                      label: Text(tr.migration.language.data),
                      items: const [
                        DropdownMenuItem(value: 'EN', child: Text('English')),
                      ],
                      onChanged: null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
