import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

import 'package:get/get.dart';

import '../../../generated/l10n.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      foregroundColor: Get.theme.colorScheme.onSurface,
      elevation: 0,
      title: Text(S.current.appName),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
