import 'dart:async';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:get/get.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/pages/auth/email_auth_view.dart';
import 'package:dungeon_paper/src/pages/auth/verify_password_dialog.dart';
import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

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
        color: Get.theme.accentColor,
        textColor: Get.theme.colorScheme.onSecondary,
        child: loading ? Loader.button() : Text(isLinked ? 'Unlink' : 'Link'),
        onPressed: isPrimary ? null : _toggleLink,
        visualDensity: VisualDensity.compact,
      ),
      visualDensity: VisualDensity.compact,
    );
  }

  Future _toggleLink() async {
    final isLinked = isUserLinkedToAuth(data.id, user);
    setState(() => loading = true);
    final verb = '${isLinked ? 'un' : ''}linking';
    final verbPast = '${isLinked ? 'un' : ''}linked';
    final preposition = !isLinked ? 'to' : 'from';
    unawaited(analytics.logEvent(
      name: isLinked ? Events.AccountUnlinkAttempt : Events.AccountLinkAttempt,
      parameters: {'provider': data.id},
    ));
    try {
      final cred = await _getCredential(context, data.id, isLinked: isLinked);
      if (isLinked) {
        await unlinkFromProvider(data.id);
        unawaited(analytics.logEvent(
          name: Events.AccountUnlinkSuccess,
          parameters: {'provider': data.id},
        ));
      } else {
        await linkWithCredentials(cred);
        unawaited(analytics.logEvent(
          name: Events.AccountLinkSuccess,
          parameters: {'provider': data.id},
        ));
      }
      if (mounted) {
        setState(() => loading = false);
      }
      Get.snackbar(
        '${capitalize(verb)} success',
        'Account was $verbPast ${preposition} ${data.displayName}',
        duration: SnackBarDuration.long,
      );
    } on SignInError catch (e) {
      setState(() {
        error = e.message == 'user_canceled'
            ? "Sign in process wasn't completed."
            : e.message;
      });
      if (isLinked) {
        unawaited(analytics.logEvent(
          name: Events.AccountUnlinkFail,
          parameters: {'provider': data.id, 'reason': 'user_cancel'},
        ));
      } else {
        unawaited(analytics.logEvent(
          name: Events.AccountLinkFail,
          parameters: {'provider': data.id, 'reason': 'user_cancel'},
        ));
      }
      Get.snackbar(
        'Problem with account $verb',
        error,
        duration: SnackBarDuration.long,
      );
    } catch (e, stack) {
      logger.e('Error with $verb', e, stack);
      setState(() {
        error = 'Something went wrong. Try again or contact us for support.';
      });
      if (isLinked) {
        unawaited(analytics.logEvent(
          name: Events.AccountUnlinkFail,
          parameters: {
            'provider': data.id,
            'reason': 'error',
            'error': e.toString()
          },
        ));
      } else {
        unawaited(analytics.logEvent(
          name: Events.AccountLinkFail,
          parameters: {
            'provider': data.id,
            'reason': 'error',
            'error': e.toString()
          },
        ));
      }
      Get.snackbar(
        'Problem with account $verb',
        error,
        duration: SnackBarDuration.long,
      );
    } finally {
      setState(() => loading = false);
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
              title: Text('Verify Password'),
              confirmText: Text('Unlink'),
              children: [
                Text(
                    'This is a sensitive operation.\nPlease re-type your password to verify:'),
              ],
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
