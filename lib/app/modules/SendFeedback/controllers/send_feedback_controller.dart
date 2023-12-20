import 'package:dungeon_paper/core/http/api.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import '../../../data/services/user_provider.dart';

class SendFeedbackController extends ChangeNotifier with UserProviderMixin {
  final email = TextEditingController();
  final title = TextEditingController();
  final body = TextEditingController();
  var sending = false;

  final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> send(BuildContext context) async {
    sending = true;
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);
    await api.requests.sendFeedback(
      email: user.isLoggedIn ? user.email : email.text,
      subject: title.text,
      body: body.text,
      username: user.isLoggedIn ? user.username : null,
    );
    navigator.pop();
    messenger.showSnackBar(
      SnackBar(
        content: Column(
          children: [
            Text(tr.feedback.success.title, style: theme.textTheme.bodyLarge),
            Text(tr.feedback.success.message),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (var element in [email, title, body]) {
      element.dispose();
    }
  }
}

