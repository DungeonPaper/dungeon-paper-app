import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/dialog_utils.dart';
import '../../model_utils/user_utils.dart';

Future<bool> confirmUnlinkProvider<T>(
    BuildContext context, ProviderName provider) {
  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
        tr.auth.confirmUnlink.title(tr.auth.providers.name(provider.name)),
      ),
      content: Text(
        tr.auth.confirmUnlink.body(tr.auth.providers.name(provider.name)),
      ),
      actions: DialogControls.negative(
        context,
        confirmLabel: tr.auth.providers.unlink,
        cancelLabel: tr.generic.cancel,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
      ),
    ),
  ).then((res) => res == true);
}

Future<void> awaitUnlinkProviderConfirmation<T>(BuildContext context,
        ProviderName provider, void Function() onConfirmed) =>
    awaitConfirmation(confirmUnlinkProvider<T>(context, provider), onConfirmed);
