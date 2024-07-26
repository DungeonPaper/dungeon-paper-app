import 'package:dungeon_paper/app/widgets/atoms/custom_snack_bar.dart';
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
    await api.requests.sendFeedback(
      email: user.isLoggedIn ? user.email : email.text,
      subject: title.text,
      body: body.text,
      username: user.isLoggedIn ? user.username : null,
    );
    navigator.pop();
    CustomSnackBar.show(
      title: tr.feedback.success.title,
      content: tr.feedback.success.message,
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
