import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final bool disabled;
  final bool valid;

  const NavItem(
      {Key? key,
      required this.icon,
      required this.onTap,
      required this.disabled,
      required this.valid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Get.theme.colorScheme.primary.withOpacity(0.1),
        onTap: onTap,
        child: SizedBox(
          height: 64,
          width: 64,
          child: Icon(icon, size: 30),
        ),
      ),
    );
  }
}
