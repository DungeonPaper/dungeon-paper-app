import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(
    this.icon, {
    super.key,
    this.color,
    this.size,
  });

  final IconData icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    final iconTheme = IconTheme.of(context);

    return SvgPicture.asset(
      icon.fontFamily!,
      color: color ?? iconTheme.color,
      width: size ?? iconTheme.size,
      height: size ?? iconTheme.size,
    );
  }
}
