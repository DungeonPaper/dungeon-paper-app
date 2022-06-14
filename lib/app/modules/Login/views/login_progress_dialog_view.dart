import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

enum LoginProgressStep {
  signin,
  loadChars,
}

class LoginProgressDialogView extends GetView<LoadingService> with CharacterServiceMixin {
  const LoginProgressDialogView({Key? key}) : super(key: key);

  String get title {
    if (controller.isLoading(LoadKey.user)) {
      return 'Signing in...';
    }

    if (controller.isLoading(LoadKey.characters)) {
      return 'Loading characters...';
    }

    return 'Loading info...';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // TODO intl
      title: Text(title),
      content: const SizedBox(
        width: 100,
        height: 100,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ),
    );
  }
}
