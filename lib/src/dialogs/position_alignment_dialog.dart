import 'dart:math' as math;

import 'package:dungeon_paper/src/dialogs/standard_dialog_controls.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PositionAlignmentDialog extends StatefulWidget {
  final Widget title;
  final Alignment alignment;
  final Function(Alignment) onSave;

  const PositionAlignmentDialog({
    Key key,
    @required this.title,
    @required this.alignment,
    @required this.onSave,
  }) : super(key: key);

  @override
  _PositionAlignmentDialogState createState() =>
      _PositionAlignmentDialogState();
}

class _PositionAlignmentDialogState extends State<PositionAlignmentDialog> {
  Alignment alignment;

  @override
  void initState() {
    super.initState();
    alignment = widget.alignment;
  }

  @override
  Widget build(BuildContext context) {
    final size = 250.0;
    return AlertDialog(
      title: widget.title,
      actions: StandardDialogControls.actions(
        context: context,
        onConfirm: () {
          Get.back();
          widget.onSave(alignment);
        },
      ),
      content: Container(
        height: size,
        width: size,
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1,
          children: [
            for (final align in [
              Alignment.topLeft,
              Alignment.topCenter,
              Alignment.topRight,
              Alignment.centerLeft,
              Alignment.center,
              Alignment.centerRight,
              Alignment.bottomLeft,
              Alignment.bottomCenter,
              Alignment.bottomRight,
            ])
              IconButton(
                icon: _icon(align),
                color: alignment == align
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
                tooltip: enumName(align)
                    .split(RegExp(r'(?=[A-Z])'))
                    .map((str) => capitalize(str))
                    .join(' '),
                onPressed: () => setState(() => alignment = align),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
          ],
        ),
      ),
    );
  }

  Widget _icon(Alignment alignment) {
    final degrees = mapSwitch<Alignment, double>({
      Alignment.topLeft: -45.0,
      Alignment.topCenter: 0.0,
      Alignment.topRight: 45.0,
      Alignment.centerLeft: -90.0,
      Alignment.center: 0.0,
      Alignment.centerRight: 90.0,
      Alignment.bottomLeft: -135.0,
      Alignment.bottomCenter: -180.0,
      Alignment.bottomRight: -225.0,
    }, alignment, defaultValue: 0.0);

    return Transform.rotate(
      angle: degrees * (math.pi / 180),
      child: Icon(
        alignment == Alignment.center ? Icons.crop_square : Icons.arrow_upward,
      ),
    );
  }
}
