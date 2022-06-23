import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoinsDialog extends StatefulWidget {
  const CoinsDialog({
    super.key,
    required this.coins,
    required this.onChanged,
  });

  final double coins;
  final void Function(double coins) onChanged;

  @override
  State<CoinsDialog> createState() => _CoinsDialogState();
}

class _CoinsDialogState extends State<CoinsDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.coins.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(DwIcons.coin_stack, size: 32),
          const SizedBox(width: 12),
          Expanded(child: Text(S.current.coins)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            NumberTextField(
              controller: controller,
              numberType: NumberType.double,
              minValue: 0.0,
            )
          ],
        ),
      ),
      actions: DialogControls.save(context, onSave: save, onCancel: cancel),
    );
  }

  void save() {
    widget.onChanged(double.parse(controller.text));
    Get.back();
  }

  void cancel() {
    Get.back();
  }
}
