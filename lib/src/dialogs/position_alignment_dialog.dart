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
    final size = 180.0;
    return AlertDialog(
      scrollable: false,
      title: widget.title,
      actions: StandardDialogControls.actions(
        context: context,
        onConfirm: () {
          Get.back();
          widget.onSave(alignment);
        },
      ),
      content: SizedBox(
        height: size,
        width: size,
        child: Container(
          child: Column(
            children: [
              for (final group in _groupedAlignments)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (final align in group)
                      SizedBox(
                        width: size / 3,
                        height: size / 3,
                        child: Tooltip(
                          child: InkWell(
                            child: _icon(align),
                            onTap: () => setState(() => alignment = align),
                          ),
                          message: _tooltip(align),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  final _groupedAlignments = [
    [
      Alignment.topLeft,
      Alignment.topCenter,
      Alignment.topRight,
    ],
    [
      Alignment.centerLeft,
      Alignment.center,
      Alignment.centerRight,
    ],
    [
      Alignment.bottomLeft,
      Alignment.bottomCenter,
      Alignment.bottomRight,
    ]
  ];

  String _tooltip(Alignment align) => enumName(align)
      .split(RegExp(r'(?=[A-Z])'))
      .map((str) => capitalize(str))
      .join(' ');

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
        color: alignment == this.alignment
            ? Get.theme.colorScheme.primary
            : Get.theme.colorScheme.onSurface,
      ),
    );
  }
}
