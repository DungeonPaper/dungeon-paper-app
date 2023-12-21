import 'package:dungeon_paper/core/http/api_requests/migration.dart';
import 'package:flutter/material.dart';

class MigrationController extends ChangeNotifier {
  final _username = TextEditingController(text: '');
  final _language = 'EN';
  late final String email;

  TextEditingController get username => _username;
  String get language => _language;

  bool get isValid => username.text.isNotEmpty && language.isNotEmpty;

  void done(BuildContext context) {
    Navigator.of(context).pop(
      MigrationDetails(
        email: email,
        username: username.text,
        language: language,
      ),
    );
  }

  MigrationController(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as dynamic;
    assert(arguments is MigrationArguments);
    final args = arguments as MigrationArguments;
    email = args.email;
    username.addListener(_refreshUsername);
  }

  @override
  dispose() {
    super.dispose();
    username.removeListener(_refreshUsername);
    username.dispose();
  }

  _refreshUsername() {
    notifyListeners();
  }
}

class MigrationArguments {
  final String email;

  MigrationArguments({required this.email});
}
