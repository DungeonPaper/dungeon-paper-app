import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/inventory_items.dart';
import 'package:dungeon_paper/db/models/notes.dart';
import 'package:dungeon_paper/src/dialogs/add_move_or_spell_dialog.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/scaffolds/add_inventory_item_scaffold.dart';
import 'package:dungeon_paper/src/scaffolds/edit_note_scaffold.dart';
import 'package:dungeon_paper/src/utils/utils.dart';

import 'nav_bar.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class FAB extends StatefulWidget {
  final PageController pageController;
  final Character character;

  const FAB({
    Key key,
    @required this.pageController,
    @required this.character,
  }) : super(key: key);

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

  static Map<Pages, Widget Function(BuildContext context, Character character)>
      buttonsByIndex = {
    Pages.Notes: (context, character) => FloatingActionButton(
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (ctx) => EditNoteScreen(
                note: Note(),
                mode: DialogMode.Create,
                onSave: (note) => createNote(character, note),
              ),
            ),
          ),
        ),
    Pages.Inventory: (context, character) => FloatingActionButton(
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (ctx) => AddInventoryItemScaffold(
                item: InventoryItem(),
                mode: DialogMode.Create,
                onSave: (item) => createInventoryItem(character, item),
              ),
            ),
          ),
        ),
    Pages.Battle: (context, character) => FloatingActionButton(
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AddMoveOrSpell(
              character: character,
              defaultClass: character.mainClass,
            ),
          ),
        ),
  };

  @override
  Widget build(BuildContext context) {
    double activeIdx = pageController.hasClients && pageController.page != null
        ? pageController.page
        : 0.0;
    double t = (activeIdx.ceil() - activeIdx).abs();
    double rt = activeIdx.ceil() - activeIdx;
    t = lerp(t < 0.5 ? 1 - t : t / 1, 0.5, 1, 0, 1);
    rt = lerp(1 - rt, 0.5, 1, 0, 1);
    var idx = Pages.values[activeIdx.round()];

    return Transform.scale(
      scale: t,
      child: Transform.rotate(
        angle: -pi * rt,
        child: activeIdx != null && buttonsByIndex.containsKey(idx)
            ? buttonsByIndex[idx](context, widget.character)
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
