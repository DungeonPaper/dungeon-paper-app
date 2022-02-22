import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/dw_icons.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(
    this.icon, {
    Key? key,
    this.color,
    this.size,
  }) : super(key: key);

  final DwIconData icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconTheme = IconTheme.of(context);

    return SvgPicture.asset(
      icon.assetPath,
      color: color ?? iconTheme.color,
      width: size ?? iconTheme.size,
      height: size ?? iconTheme.size,
    );
  }
}
