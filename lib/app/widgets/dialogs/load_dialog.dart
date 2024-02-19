import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class LoadDialog extends StatefulWidget {
  const LoadDialog({
    super.key,
    required this.load,
    required this.defaultLoad,
    required this.onChanged,
  });

  final double? load;
  final double defaultLoad;
  final void Function(double? load) onChanged;

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
    controller = TextEditingController(
        text: (widget.load ?? widget.defaultLoad).toString());
    controller.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(DwIcons.dumbbell, size: 32),
          const SizedBox(width: 12),
          Expanded(child: Text(tr.character.data.load.maxLoad)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            CheckboxListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              value: useDefault,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) => setState(() {
                useDefault = value!;
                if (value) {
                  controller.text = widget.defaultLoad.toString();
                }
              }),
              title: Text(tr.character.data.load.autoMaxLoad),
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
          onSave: useDefault || controller.text.isNotEmpty ? save : null,
          onCancel: cancel),
    );
  }

  void save() {
    widget.onChanged(useDefault ? null : double.parse(controller.text));
    Navigator.of(context).pop();
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  void _listener() {
    setState(() {});
  }
}
