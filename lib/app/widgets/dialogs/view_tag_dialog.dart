import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewTagDialog extends StatelessWidget {
  const ViewTagDialog({
    super.key,
    required this.tag,
  });

  final dw.Tag tag;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(tr.tags.dialog.title),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr.generic.entityName(
                          tr.entity(tn(dw.Tag)),
                        ),
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        toTitleCase(tag.name),
                        textScaler: const TextScaler.linear(1.8),
                      ),
                    ],
                  ),
                ),
                if (tag.value != null) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr.generic.entityValue(
                            tr.entity(tn(dw.Tag)),
                          ),
                          style: textTheme.bodySmall,
                        ),
                        Text(
                          tag.value.toString(),
                          textScaler: const TextScaler.linear(1.8),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            if (tag.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                tr.generic.entityDescription(
                  tr.entity(tn(dw.Tag)),
                ),
                style: textTheme.bodySmall,
              ),
              Text(
                tag.description,
                textScaler: const TextScaler.linear(0.9),
              ),
            ],
          ],
        ),
      ),
      actions: DialogControls.done(context, () => Get.back()),
    );
  }
}
