import 'package:dungeon_paper/notes_view/edit_note_dialog.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';

enum Pages { Home, Profile }

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

  Widget _item(BuildContext context, Widget label, IconData icon, num _index) {
    var _color = activePageIndex != null && activePageIndex.round() == _index
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

class NavBar extends StatefulWidget {
  final PageController pageController;
  NavBar({Key key, @required this.pageController}) : super(key: key);

  @override
  NavBarState createState() => NavBarState(pageController: pageController);
}

class ActionButtonsState extends State<ActionButtons> {
  final PageController pageController;
  num activePageIndex;

  ActionButtonsState({
    Key key,
    @required this.pageController,
  });

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

  static Map<num, Widget Function(BuildContext context)> buttonsByIndex = {
    Pages.Profile.index: (context) => FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
              context: context,
              builder: (_ctx) => EditNoteDialog(
                    title: '',
                    category: '',
                    description: '',
                    mode: DialogMode.Create,
                    index: -1,
                  )),
          foregroundColor: Colors.white,
          mini: true,
        ),
  };

  @override
  Widget build(BuildContext context) {
    Widget pageButton = activePageIndex != null && buttonsByIndex.containsKey(activePageIndex.round())
        ? buttonsByIndex[activePageIndex.round()](context)
        : Opacity(
            opacity: 0,
            child: IgnorePointer(
                child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {},
              mini: true,
            )));

    List<Widget> buttons = [
      Container(
        padding: EdgeInsets.only(bottom: 4),
        child: pageButton,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: FloatingActionButton(
          child: Icon(Icons.apps),
          onPressed: () {},
          foregroundColor: Colors.white,
        ),
      ),
    ];

    return Container(
      margin: buttons.length == 2 ? EdgeInsets.only(bottom: 42) : null,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: buttons),
    );
  }

  @override
  void dispose() {
    pageController.removeListener(this.pageListener);
    super.dispose();
  }
}

class ActionButtons extends StatefulWidget {
  final PageController pageController;

  const ActionButtons({Key key, this.pageController}) : super(key: key);

  @override
  ActionButtonsState createState() =>
      ActionButtonsState(pageController: pageController);
}
