import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bonds_flags_form_controller.dart';

class BondsFlagsFormView extends GetView<BondsFlagsFormController> {
  const BondsFlagsFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.current.characterBondsFlagsDialogTitle),
            centerTitle: true,
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: controller.save,
            icon: const Icon(Icons.save),
            label: Text(S.current.save),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // TODO intl
              Text('Bonds', style: textTheme.headline5),
              for (final bond in enumerate(controller.bondsDesc))
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => controller.removeBond(bond.index),
                  ),
                  title: TextField(
                    controller: bond.value,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 5,
                  ),
                ),
              OutlinedButton.icon(
                onPressed: () => controller.addBond(),
                label: const Text('Create Bond'),
                icon: const Icon(Icons.add),
              ),

              const Divider(height: 24),

              // TODO intl
              Text('Flags', style: textTheme.headline5),
              for (final flag in enumerate(controller.flagsDesc))
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => controller.removeFlag(flag.index),
                  ),
                  title: TextField(
                    controller: flag.value,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 1,
                    maxLines: 5,
                  ),
                ),
              OutlinedButton.icon(
                onPressed: () => controller.addFlag(),
                label: const Text('Create Flag'),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
