import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> confirmDelete<T>(BuildContext context, String name) {
  return Get.dialog<bool>(
    AlertDialog(
      title: Text(S.current.confirmDeleteTitle(S.current.entity(T))),
      content: Text(S.current.confirmDeleteBody(S.current.entity(T), name)),
      actions: [
        ElevatedButton.icon(
          icon: const Icon(Icons.close),
          label: Text(S.current.cancel),
          onPressed: () => Get.back(result: false),
          style: ButtonThemes.primaryElevated(context),
        ),
        // const SizedBox(width: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.delete),
          label: Text(S.current.remove),
          onPressed: () => Get.back(result: true),
          style: ButtonThemes.errorElevated(context),
        ),
        const SizedBox(width: 0),
      ],
    ),
  ).then((res) => res == true);
}

Future<void> awaitConfirmation(Future<bool> confirmation, void Function() callback) =>
    confirmation.then((res) {
      if (res) callback();
    });
