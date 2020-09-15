import 'dart:math';
import 'package:dungeon_paper/src/atoms/version_number.dart';
import 'package:dungeon_paper/src/flutter_utils/loading_container.dart';
import 'package:dungeon_paper/src/pages/about_view/about_view.dart';
import 'package:dungeon_paper/src/pages/scaffold/login_button.dart';
import 'package:dungeon_paper/src/utils/auth/credentials/google_credentials.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  final bool loading;
  final PageController pageController;

  const WelcomeView({
    Key key,
    @required this.loading,
    @required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
      loading: loading,
      child: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: SingleChildScrollView(
          primary: true,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: SizedBox.fromSize(
                    size: Size.square(
                        min(MediaQuery.of(context).size.width - 32, 200)),
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                Text('Welcome to Dungeon Paper!',
                    style: TextStyle(fontSize: 24)),
                VersionNumber.text(prefix: 'Version'),
                SizedBox(height: 24),
                LoginButton<GoogleCredentials>(onUserChange: () {
                  pageController.jumpToPage(0);
                }),
                SizedBox(height: 20),
                Text('Trouble signing in?'),
                RaisedButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: _openAboutView(context),
                  child: Text('Contact Us'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Function() _openAboutView(BuildContext context) {
    return () {
      Navigator.push(
        context,
        MaterialPageRoute<bool>(
          fullscreenDialog: true,
          builder: (context) => AboutView(),
        ),
      );
    };
  }
}
