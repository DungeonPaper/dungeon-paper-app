import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/loading_provider.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LoginProgressStep {
  signin,
  loadChars,
}

class LoginProgressDialogView extends StatelessWidget
    with CharacterProviderMixin, LoadingProviderMixin {
  const LoginProgressDialogView({super.key});

  String get title {
    if (loadingProvider.loadingUser) {
      return tr.loading.user;
    }

    if (loadingProvider.loadingCharacters) {
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
