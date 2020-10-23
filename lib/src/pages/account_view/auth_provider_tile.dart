import 'dart:async';
import 'package:get/get.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/pages/auth/email_auth_view.dart';
import 'package:dungeon_paper/src/pages/auth/verify_password_dialog.dart';
import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthProviderTileData {
  final String id;
  final String displayName;

  AuthProviderTileData({
    @required this.id,
    @required this.displayName,
  });
}

class AuthProviderTile extends StatefulWidget {
  const AuthProviderTile({
    Key key,
    @required this.data,
    @required this.user,
  }) : super(key: key);

  final AuthProviderTileData data;
  final fb.User user;

  @override
  _AuthProviderTileState createState() => _AuthProviderTileState();
}

class _AuthProviderTileState extends State<AuthProviderTile> {
  bool loading;
  bool isAvailable;
  AuthProviderTileData get data => widget.data;
  fb.User get user => widget.user;
  String error;

  @override
  void initState() {
    loading = false;
    isAvailable = data.id != 'apple.com';
    error = null;
    if (data.id == 'apple.com') {
      _getAppleAvailability();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!isAvailable) {
      return Container();
    }

    final primary = getPrimaryAuthProvider(user);
    final isPrimary = primary?.providerId == data.id;
    final isLinked =
        user?.providerData?.any((d) => d.providerId == data.id) == true;
    final current = getAuthProvider(data.id, user);
    final email = current?.email;
    final title = data.displayName;
    final subtitle = email;

    return ListTile(
      title: isPrimary
          ? Row(children: [
              Text(title),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.cyan[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                child: Text(
                  'Primary',
                  textScaleFactor: 0.8,
                ),
              ),
            ])
          : Text(title),
      subtitle: subtitle?.isNotEmpty == true ? Text(subtitle) : null,
      trailing: RaisedButton(
        color: Theme.of(context).accentColor,
        textColor: Theme.of(context).colorScheme.onSecondary,
        child: loading
            ? Loader(
                size: Size.square(16),
                strokeWidth: 2,
              )
            : Text(isLinked ? 'Unlink' : 'Link'),
        onPressed: isPrimary ? null : _toggleLink,
        visualDensity: VisualDensity.compact,
      ),
      visualDensity: VisualDensity.compact,
    );
  }

  Future _toggleLink() async {
    final isLinked = isUserLinkedToAuth(data.id, user);
    setState(() => loading = true);
    final cred = await _getCredential(context, data.id, isLinked: isLinked);
    try {
      if (isLinked) {
        await unlinkFromProvider(data.id);
      } else {
        await linkWithCredentials(cred);
      }
      if (mounted) {
        setState(() => loading = false);
      }
    } catch (e) {
      setState(() {
        loading = false;
        error = e.message;
      });
      Get.snackbar(
          'Problem with account ${!isLinked ? 'un' : ''}linking', e.message);
    }
  }

  Future<AuthCredential> _getCredential(
    BuildContext context,
    String providerId, {
    bool isLinked = false,
  }) async {
    switch (providerId) {
      case 'google.com':
        return getGoogleCredential(interactive: true);
      case 'apple.com':
        return getAppleCredential(interactive: true);
      case 'password':
        final result = await _emailAuthDialog(context, isLinked);
        Get.back();
        return result;
      default:
        return null;
    }
  }

  Future<EmailAuthCredential> _emailAuthDialog(
      BuildContext context, bool isLinked) {
    var completer = Completer<EmailAuthCredential>();
    setState(() => loading = false);
    showDialog(
      context: context,
      builder: (context) => !isLinked
          ? EmailAuthView(
              canSwitchModes: false,
              mode: EmailAuthViewMode.signUp,
              onClose: () => setState(() => loading = false),
              onConfirm: (result) async {
                completer.complete(result.credential);
                setState(() => loading = true);
                return EmailAuthResponse();
              },
            )
          : VerifyPasswordDialog(
              onConfirm: (pwd) {
                completer.complete(
                  EmailAuthProvider.credential(
                    email: user.email,
                    password: pwd,
                  ) as EmailAuthCredential,
                );
                setState(() => loading = true);
                return EmailAuthResponse();
              },
            ),
    );
    return completer.future;
  }

  Future<void> _getAppleAvailability() async {
    final canUseAppleID = await checkAppleSignIn();
    setState(() => isAvailable = canUseAppleID);
  }
}
