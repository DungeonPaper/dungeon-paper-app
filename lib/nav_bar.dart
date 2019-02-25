import 'dart:math';

import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';

enum Pages { Home, Profile }

class NavBar extends StatefulWidget {
  final PageController pageController;
  NavBar({Key key, @required this.pageController}) : super(key: key);

  @override
  NavBarState createState() => NavBarState(pageController: pageController);
}

class NavBarState extends State<NavBar> {
  final PageController pageController;
  num activePageIndex = 0;

  NavBarState({Key key, @required this.pageController});

  @override
  void initState() {
    pageController.addListener(this.pageListener);
    super.initState();
  }

  void pageListener() {
    setState(() {
      activePageIndex = pageController.page;
    });
  }

  Widget _item(BuildContext context, Widget label, IconData icon, num _index) =>
      PageNavItem(
          index: _index,
          label: label,
          icon: icon,
          pageController: pageController);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(context, Text('Profile'), Icons.person, Pages.Home.index),
          _item(
              context, Text('Notes'), Icons.speaker_notes, Pages.Profile.index),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.removeListener(this.pageListener);
    super.dispose();
  }
}

class PageNavItem extends StatelessWidget {
  const PageNavItem({
    Key key,
    @required this.index,
    @required this.pageController,
    @required this.label,
    @required this.icon,
  }) : super(key: key);

  final num index;
  final PageController pageController;
  final Widget label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // var _color = pageController.page.round() == index
    //     ?
    //     : Theme.of(context).colorScheme.onSurface;
    double activeIdx = pageController.page != null ? pageController.page : 0.0;
    double t = clamp((activeIdx - index).abs(), 0, 1);
    Color _color = Color.lerp(Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.onSurface, t);

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: 60,
          child: InkWell(
            onTap: () {
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutQuart);
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: _color),
                DefaultTextStyle(style: TextStyle(color: _color), child: label)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
