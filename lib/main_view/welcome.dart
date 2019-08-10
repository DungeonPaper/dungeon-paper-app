import 'package:dungeon_paper/widget_utils.dart';

import '../about_view/feedback_icon_button.dart';
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
      child: Center(
        child: loading
            ? PAGE_LOADER
            : Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text('Welcome to Dungeon Paper!',
                        style: TextStyle(fontSize: 24)),
                  ),
                  LoginButton(onUserChange: () {
                    pageController.jumpToPage(0);
                  }),
                  SizedBox(height: 20),
                  Text('Having trouble signing in?'),
                  FeedbackButton.hyperlink(dontWaitForUser: true)
                ],
              ),
      ),
    );
  }
}
