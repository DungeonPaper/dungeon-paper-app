import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/dialog_utils.dart';
import '../../model_utils/user_utils.dart';

Future<bool> confirmUnlinkProvider<T>(BuildContext context, ProviderName provider) {
  return Get.dialog<bool>(
    AlertDialog(
      title: Text(S.current.confirmUnlinkProviderTitle(S.current.signinProvider(provider))),
      content: Text(S.current.confirmUnlinkProviderBody(S.current.signinProvider(provider))),
      actions: DialogControls.negative(
        context,
        confirmLabel: S.current.signinProviderUnlink,
        cancelLabel: S.current.cancel,
        onConfirm: () => Get.back(result: true),
        onCancel: () => Get.back(result: false),
      ),
    ),
  ).then((res) => res == true);
}

Future<void> awaitUnlinkProviderConfirmation<T>(
        BuildContext context, ProviderName provider, void Function() onConfirmed) =>
    awaitConfirmation(confirmUnlinkProvider<T>(context, provider), onConfirmed);
