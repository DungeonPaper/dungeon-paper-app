import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

class ViewTagDialog extends StatelessWidget {
  const ViewTagDialog({
    Key? key,
    required this.tag,
  }) : super(key: key);

  final dw.Tag tag;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(S.current.tagDetails),
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
                        S.current.genericNameField(
                          S.current.entity(dw.Tag),
                        ),
                        style: textTheme.bodySmall,
                      ),
                      Text(
                        toTitleCase(tag.name),
                        textScaleFactor: 1.8,
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
                          S.current.genericValueField(
                            S.current.entity(dw.Tag),
                          ),
                          style: textTheme.bodySmall,
                        ),
                        Text(
                          tag.value.toString(),
                          textScaleFactor: 1.8,
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
                S.current.genericDescriptionField(
                  S.current.entity(dw.Tag),
                ),
                style: textTheme.bodySmall,
              ),
              Text(
                tag.description,
                textScaleFactor: 0.9,
              ),
            ],
          ],
        ),
      ),
      actions: DialogControls.done(context, () => Get.back()),
    );
  }
}
