import 'package:dungeon_paper/src/pages/account_view/provider_link.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:dungeon_paper/src/utils/auth/auth_common.dart';
import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  static final _providersData = [
    ProviderLinkData(
        id: 'google.com', displayName: 'Google', link: (_) async => true),
    ProviderLinkData(
        id: 'apple.com', displayName: 'Apple', link: (_) async => true),
    ProviderLinkData(
        id: 'password', displayName: 'Email', link: (_) async => true),
  ];

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<UserLogin>(
      converter: (store) => UserLogin(
        user: store.state.user.current,
        firebaseUser: store.state.user.firebaseUser,
      ),
      builder: (context, login) {
        final firstNonFbProvider = login.firebaseUser.providerData.firstWhere(
          (data) => data.providerId != 'firebase',
          orElse: () => null,
        );
        return ScaffoldWithElevation(
          title: Text('Your Account'),
          body: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(login.user.photoURL),
                  radius: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    login.user.displayName,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              for (var provider in _providersData)
                ListTile(
                  title: Text(provider.displayName),
                  subtitle: firstNonFbProvider.providerId == provider.id
                      ? Text('Primary login')
                      : null,
                  trailing: RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).colorScheme.onSecondary,
                    child: Text('Link'),
                    onPressed: () {},
                  ),
                  visualDensity: VisualDensity.compact,
                )
            ],
          ),
        );
      },
    );
  }
}
