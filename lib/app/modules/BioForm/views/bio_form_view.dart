import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/modules/BioForm/controllers/bio_form_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/rich_text_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BioFormView extends GetView<BioFormController>
    with CharacterServiceMixin {
  const BioFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            title: Text(tr.bio.dialog.title),
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: _save,
            label: Text(tr.generic.save),
            icon: const Icon(Icons.save),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              RichTextField(
                controller: controller.bioDesc.value,
                minLines: 5,
                maxLines: 10,
                textCapitalization: TextCapitalization.sentences,
                onChanged: controller.setDirty,
                decoration: InputDecoration(
                  label: Text(tr.bio.dialog.description.label),
                  hintText: tr.bio.dialog.description.placeholder,
                ),
              ),
              const SizedBox(height: 8),
              RichTextField(
                controller: controller.looks.value,
                minLines: 4,
                maxLines: 8,
                textCapitalization: TextCapitalization.sentences,
                onChanged: controller.setDirty,
                decoration: InputDecoration(
                  label: Text(tr.bio.dialog.looks.label),
                  hintText: tr.bio.dialog.looks.placeholder,
                ),
              ),
              const SizedBox(height: 24),
              SelectBox<String>(
                value: controller.alignmentName.value,
                items: AlignmentValue.allKeys
                    .map(
                      (a) => DropdownMenuItem<String>(
                        value: a,
                        child: Row(
                          children: [
                            Icon(AlignmentValue.iconMap[a]!),
                            const SizedBox(width: 4),
                            Text(tr.alignment.name(a)),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  controller.alignmentName.value = v!;
                  controller.setDirty();
                },
                isExpanded: true,
                label: Text(tr.bio.dialog.alignment.label),
              ),
              const SizedBox(height: 8),
              RichTextField(
                controller: controller.alignmentValue.value,
                minLines: 4,
                maxLines: 8,
                textCapitalization: TextCapitalization.sentences,
                onChanged: controller.setDirty,
                decoration: InputDecoration(
                  label: Text(tr.bio.dialog.alignmentDescription.label),
                  hintText: tr.bio.dialog.alignmentDescription.placeholder,
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    controller.save();
    Get.back();
  }
}
