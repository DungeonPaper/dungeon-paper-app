import 'package:dungeon_paper/main_view/login_button.dart';
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
            ? CircularProgressIndicator(value: null)
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
                  })
                ],
              ),
      ),
    );
  }
}
