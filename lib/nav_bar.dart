import 'package:flutter/material.dart';

class NavBarState extends State<NavBar> {
  final PageController pageController;
  num index = 0;

  NavBarState({Key key, @required this.pageController}) {
    pageController.addListener(this.pageListener);
  }

  void pageListener() {
    setState(() {
      index = pageController.page;
    });
  }

  Widget _item(BuildContext context, Widget label, IconData icon, num _index) {
    var _color = index.round() == _index
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: 70,
          child: InkWell(
            onTap: () {
              pageController.animateToPage(_index,
                  duration: Duration(milliseconds: 500), curve: Curves.easeOut);
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

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(context, Text('Profile'), Icons.person, 0),
          _item(context, Text('Notes'), Icons.speaker_notes, 1),
        ],
      ),
    );
  }
}

class NavBar extends StatefulWidget {
  final PageController pageController;
  NavBar({Key key, @required this.pageController}) : super(key: key);

  @override
  NavBarState createState() => NavBarState(pageController: pageController);
}
