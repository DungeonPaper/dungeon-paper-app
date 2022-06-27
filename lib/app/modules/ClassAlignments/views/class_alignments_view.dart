import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/class_alignments_controller.dart';

class ClassAlignmentsView extends GetView<ClassAlignmentsController> {
  const ClassAlignmentsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.selectGeneric(S.current.entity(AlignmentValue))),
        centerTitle: true,
      ),
      floatingActionButton: controller.onChanged != null
          ? AdvancedFloatingActionButton.extended(
              onPressed: controller.save,
              label: Text(S.current.save),
              icon: const Icon(Icons.save),
            )
          : null,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0).copyWith(bottom: 80),
        children: [
          for (final alignment in controller.sortedAlignmentTypes)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Obx(() {
                final description = controller.alignments.value.byType(alignment);
                final isEditing = controller.isEditing(alignment);
                final isSelected = controller.isSelected(alignment);

                return _wrapWithSelection(
                  isSelected,
                  Card(
                    margin: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          minLeadingWidth: 16,
                          leading: Icon(AlignmentValue.iconOf(alignment)),
                          title: Text(S.current.alignment(alignment)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: !isEditing
                                ? [
                                    if (controller.editable)
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () => controller.toggleEdit(alignment, true),
                                        iconSize: 16,
                                      ),
                                    if (controller.selectable)
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.check),
                                        label: Text(
                                            !isSelected ? S.current.select : S.current.selected),
                                        onPressed:
                                            !isSelected ? () => controller.select(alignment) : null,
                                      ),
                                  ]
                                : DialogControls.done(
                                    context, () => controller.toggleEdit(alignment, false)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8).copyWith(left: 56, top: 0),
                          child: !isEditing
                              ? Text(description.isEmpty ? S.current.noDescription : description)
                              : TextField(
                                  controller: controller.textControllers[alignment]!,
                                ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
        ],
      ),
    );
  }

  Widget _wrapWithSelection(bool isSelected, Card child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          width: 2,
          color: isSelected ? DwColors.success : Colors.transparent,
        ),
      ),
      child: child,
    );
  }
}
