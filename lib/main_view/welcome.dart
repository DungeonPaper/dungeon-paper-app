import 'dart:math';

import 'package:dungeon_paper/components/version_number.dart';
import 'package:dungeon_paper/widget_utils.dart';

import '../about_view/feedback_button.dart';
import '../main_view/login_button.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  final bool loading;
  final PageController pageController;

  const Welcome({
    Key key,
    @required this.loading,
    @required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: loading
          ? const Center(child: PAGE_LOADER)
          : SingleChildScrollView(
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
                    LoginButton(onUserChange: () {
                      pageController.jumpToPage(0);
                    }),
                    SizedBox(height: 20),
                    Text('Having trouble signing in?'),
                    FeedbackButton.hyperlink(dontWaitForUser: true)
                  ],
                ),
              ),
            ),
    );
  }
}
