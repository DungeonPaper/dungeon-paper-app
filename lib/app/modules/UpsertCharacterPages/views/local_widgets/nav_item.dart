import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavItem extends StatelessWidget {
  final Widget icon;
  final void Function()? onTap;
  final bool disabled;
  final bool valid;
  final bool active;

  const NavItem({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.disabled,
    required this.valid,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Get.theme.colorScheme.primary.withOpacity(0.1),
        onTap: disabled ? null : onTap,
        child: Stack(
          children: [
            SizedBox(
              height: 64,
              width: 64,
              child: IconTheme(
                child: icon,
                data: IconTheme.of(context).copyWith(
                  size: 30,
                  color: active
                      ? theme.colorScheme.secondary
                      :
                      // theme.scaffoldBackgroundColor.computeLuminance() > 0.5 ? theme.colorScheme.onSurface
                      theme.colorScheme.onSurface.withOpacity(!disabled ? 0.5 : 0.2),
                ),
              ),
            ),
            if (!disabled)
              Positioned.directional(
                textDirection: TextDirection.ltr,
                end: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: valid ? DwColors.success : DwColors.warning,
                  ),
                  child: Center(
                    child: IconTheme(
                      data: IconTheme.of(context).copyWith(color: Colors.white),
                      child: valid
                          ? const Icon(Icons.check, size: 8)
                          : SvgIcon(DwIcons.exclamation, size: 8),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
