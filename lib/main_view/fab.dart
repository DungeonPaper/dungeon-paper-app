import 'dart:math';
import 'package:dungeon_paper/battle_view/edit_move_dialog.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_paper/main_view/nav_bar.dart';
import 'package:dungeon_paper/notes_view/edit_note_dialog.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/move.dart';
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
                  fullscreenDialog: true,
                  builder: (ctx) => EditNoteScreen(
                        note: Note(),
                        mode: DialogMode.Create,
                        index: -1,
                      ),
                ),
              ),
        ),
    Pages.Battle.index: (context) => FloatingActionButton(
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => EditMoveScreen(
                        move: Move(),
                        mode: DialogMode.Create,
                        index: -1,
                      ),
                ),
              ),
        ),
  };

  @override
  Widget build(BuildContext context) {
    double activeIdx = pageController.page != null ? pageController.page : 0.0;
    double t = (activeIdx.ceil() - activeIdx).abs();
    t = lerp(t < 0.5 ? 1 - t : t / 1, 0.5, 1, 0, 1);

    return Transform.scale(
      scale: t,
      child: Transform.rotate(
        angle: -pi * t,
        child: activeIdx != null && buttonsByIndex.containsKey(activeIdx.round())
          ? buttonsByIndex[activeIdx.round()](context)
          : SizedBox.shrink(),
      ),
    );
  }

  @override
  void dispose() {
    pageController.removeListener(this.pageListener);
    super.dispose();
  }
}
