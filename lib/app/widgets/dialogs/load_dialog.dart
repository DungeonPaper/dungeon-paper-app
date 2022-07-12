import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadDialog extends StatefulWidget {
  const LoadDialog({
    super.key,
    required this.load,
    required this.onChanged,
  });

  final int? load;
  final void Function(int? load) onChanged;

  @override
  State<LoadDialog> createState() => _LoadDialogState();
}

class _LoadDialogState extends State<LoadDialog> {
  late TextEditingController controller;
  late bool useDefault;

  @override
  void initState() {
    super.initState();
    useDefault = widget.load == null;
    controller = TextEditingController(text: widget.load?.toString() ?? '');
    controller.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(DwIcons.dumbbell, size: 32),
          const SizedBox(width: 12),
          Expanded(child: Text(S.current.maxLoad)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              minLeadingWidth: 20,
              onTap: () => setState(() {
                useDefault = !useDefault;
                if (useDefault) {
                  controller.text = '';
                }
              }),
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: SizedBox(
                width: 20,
                child: Checkbox(
                  value: useDefault,
                  onChanged: (value) => setState(() {
                    useDefault = value!;
                    if (value) {
                      controller.text = '';
                    }
                  }),
                ),
              ),
              title: Text(S.current.characterAutoMaxLoad),
            ),
            NumberTextField(
              controller: controller,
              numberType: NumberType.int,
              minValue: 0,
              enabled: !useDefault,
            )
          ],
        ),
      ),
      actions: DialogControls.save(context,
          onSave: useDefault || controller.text.isNotEmpty ? save : null, onCancel: cancel),
    );
  }

  void save() {
    widget.onChanged(useDefault ? null : int.parse(controller.text));
    Get.back();
  }

  void cancel() {
    Get.back();
  }

  void _listener() {
    setState(() {});
  }
}
