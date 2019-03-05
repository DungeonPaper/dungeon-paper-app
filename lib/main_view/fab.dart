import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/main_view/nav_bar.dart';
import 'package:dungeon_paper/notes_view/edit_note_dialog.dart';
import 'package:flutter/material.dart';

class FAB extends StatefulWidget {
  final PageController pageController;

  const FAB({Key key, this.pageController}) : super(key: key);

  @override
  FABState createState() => FABState(pageController: pageController);
}

class FABState extends State<FAB> {
  final PageController pageController;
  num activePageIndex;

  FABState({
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
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => EditNoteScreen(
                        note: Note(),
                        mode: DialogMode.Create,
                        index: -1,
                      ),
                ),
              ),
          // mini: true,
        ),
  };

  @override
  Widget build(BuildContext context) {
    return activePageIndex != null &&
            buttonsByIndex.containsKey(activePageIndex.round())
        ? buttonsByIndex[activePageIndex.round()](context)
        : Container();
  }

  @override
  void dispose() {
    pageController.removeListener(this.pageListener);
    super.dispose();
  }
}
