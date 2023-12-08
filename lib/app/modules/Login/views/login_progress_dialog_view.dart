import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LoginProgressStep {
  signin,
  loadChars,
}

class LoginProgressDialogView extends GetView<LoadingService>
    with CharacterServiceMixin {
  const LoginProgressDialogView({super.key});

  String get title {
    if (controller.loadingUser) {
      return tr.loading.user;
    }

    if (controller.loadingCharacters) {
      return tr.loading.characters;
    }

    return tr.loading.general;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AlertDialog(
        title: Text(title),
        content: const SizedBox.square(
          dimension: 100,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ),
    );
  }
}
