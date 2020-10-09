import 'package:dungeon_paper/src/dialogs/single_field_edit_dialog.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/pages/account_view/auth_provider_tile.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:dungeon_paper/src/utils/auth/auth.dart';
import 'package:dungeon_paper/src/utils/auth/auth_common.dart';
import 'package:dungeon_paper/src/utils/share.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  static final _providersData = [
    AuthProviderTileData(
      id: 'password',
      displayName: 'Email & Password',
    ),
    AuthProviderTileData(
      id: 'google.com',
      displayName: 'Google',
    ),
    AuthProviderTileData(
      id: 'apple.com',
      displayName: 'Apple',
    ),
  ];

  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  bool passwordResetSent;
  bool loadingPasswordReset;

  @override
  void initState() {
    passwordResetSent = false;
    loadingPasswordReset = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<UserLogin>(
      converter: (store) => UserLogin(
        user: store.state.user.current,
        firebaseUser: store.state.user.firebaseUser,
      ),
      builder: (context, login) {
        final user = login.user;
        final fbUser = login.firebaseUser;
        final hasPassword = isUserLinkedToAuth('password', fbUser);
        final hasAvatar = user.photoURL?.isNotEmpty == true;
        final initials = user.displayName
            .split(RegExp(r'[\.\s]+'))
            .take(2)
            .map((word) => word[0].toUpperCase())
            .join('');
        return ScaffoldWithElevation(
          automaticallyImplyLeading: true,
          title: Text('Your Account'),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage:
                      hasAvatar ? NetworkImage(user.photoURL) : null,
                  child: !hasAvatar
                      ? Text(
                          initials,
                          textScaleFactor: 2,
                        )
                      : null,
                  radius: 50,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 16),
              //   child: Center(
              //     child: Text(
              //       user.displayName,
              //       style: Theme.of(context).textTheme.headline5,
              //     ),
              //   ),
              // ),
              Card(
                margin: EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Display name'),
                      subtitle: Text(user.displayName),
                      trailing: Icon(Icons.edit),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => SingleTextFieldEditDialog(
                          value: user.displayName,
                          fieldName: 'Display Name',
                          title: Text('Edit Display Name'),
                          onSave: (displayName) async {
                            user.displayName = displayName;
                            await user.update();
                            Navigator.pop(context);
                          },
                          onCancel: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    if (hasPassword) ...[
                      ListTile(
                        title: Text('Email address'),
                        subtitle: Text(user.email),
                        trailing: Icon(Icons.edit),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => SingleTextFieldEditDialog(
                            value: user.email,
                            fieldName: 'Email address',
                            title: Text('Edit Email'),
                            onSave: (email) async {
                              await user.changeEmail(email);
                              Navigator.pop(context);
                            },
                            onCancel: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Password'),
                        subtitle: passwordResetSent
                            ? Text(passwordResetSent
                                ? 'A password reset link has been sent to your email address.'
                                : 'You can log in using your email and password')
                            : null,
                        trailing: FlatButton(
                          textColor: Theme.of(context).colorScheme.secondary,
                          child: loadingPasswordReset
                              ? Loader(
                                  size: Size.square(16),
                                  strokeWidth: 2,
                                  color: Theme.of(context).accentColor,
                                )
                              : Text(passwordResetSent
                                  ? 'Send Again'
                                  : 'Reset Password'),
                          onPressed: () => _sendPasswordReset(context),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Ways to log in',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    for (var provider in AccountView._providersData)
                      AuthProviderTile(
                        data: provider,
                        user: fbUser,
                      )
                  ],
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Need help on your adventure?\nStuck trying to save the universe?',
                      textAlign: TextAlign.center,
                    ),
                    RaisedButton(
                      child: Text('Invite a friend', textScaleFactor: 1.1),
                      color: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).colorScheme.onSecondary,
                      onPressed: shareAppLink,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendPasswordReset(BuildContext context) async {
    setState(() => loadingPasswordReset = true);
    await sendPasswordResetLink();
    setState(() {
      loadingPasswordReset = false;
      passwordResetSent = true;
    });
  }
}
