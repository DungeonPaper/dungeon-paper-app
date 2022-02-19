import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabeledIconButton extends StatelessWidget {
  const LabeledIconButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final Widget icon;
  final void Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    var fgColor = Get.theme.colorScheme.onPrimary;
    return Ink(
      decoration: ShapeDecoration(
        color: Get.theme.primaryColor,
        shape: const CircleBorder(),
      ),
      width: 64,
      height: 64,
      child: IconButton(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconTheme(
              data: IconThemeData(color: fgColor),
              child: icon,
            ),
            Text(
              label,
              textScaleFactor: 0.8,
              style: TextStyle(color: fgColor),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
