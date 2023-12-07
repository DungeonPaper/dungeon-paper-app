import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bonds_flags_form_controller.dart';

class BondsFlagsFormView extends GetView<BondsFlagsFormController> {
  const BondsFlagsFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            title: Text(tr.flags.title),
            centerTitle: true,
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: controller.save,
            icon: const Icon(Icons.save),
            label: Text(tr.generic.save),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(tr.flags.bonds, style: textTheme.headlineSmall),
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
                label: Text(tr.generic.createEntity(tr.flags.bond)),
                icon: const Icon(Icons.add),
              ),
              const Divider(height: 24),
              Text(tr.flags.flags, style: textTheme.headlineSmall),
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
                label: Text(tr.generic.createEntity(tr.flags.flag)),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
