import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArmorDialog extends StatefulWidget {
  const ArmorDialog({
    super.key,
    required this.armor,
    required this.defaultArmor,
    required this.onChanged,
  });

  final int? armor;
  final int defaultArmor;
  final void Function(int? armor) onChanged;

  @override
  State<ArmorDialog> createState() => _ArmorDialogState();
}

class _ArmorDialogState extends State<ArmorDialog> {
  late TextEditingController controller;
  late bool useDefault;

  @override
  void initState() {
    super.initState();
    useDefault = widget.armor == null;
    controller = TextEditingController(
        text: widget.armor?.toString() ?? widget.defaultArmor.toString());
    controller.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(DwIcons.armor, size: 32),
          const SizedBox(width: 12),
          Expanded(child: Text(tr.armor.dialog.title)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              // minLeadingWidth: 20,
              title: Text(tr.armor.dialog.title),
              dense: true,
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.leading,
              value: useDefault,
              onChanged: (value) => setState(() {
                final newValue = value ?? !useDefault;
                useDefault = newValue;
                if (newValue) {
                  controller.text = '${widget.defaultArmor}';
                }
              }),
            ),
            const SizedBox(height: 8),
            NumberTextField(
              controller: controller,
              numberType: NumberType.int,
              decoration: InputDecoration(
                  hintText: '0', label: Text(tr.armor.dialog.title)),
              minValue: 0,
              enabled: !useDefault,
            )
          ],
        ),
      ),
      actions: DialogControls.save(
        context,
        onSave: useDefault || controller.text.isNotEmpty ? save : null,
        onCancel: cancel,
      ),
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
