import 'package:dungeon_paper/db/spells.dart';
import '../../components/dialogs.dart';
import 'add_spell_list.dart';
import 'package:flutter/material.dart';

import 'custom_spell_screen.dart';

class AddSpellScreen extends StatefulWidget {
  const AddSpellScreen({
    Key key,
    @required this.index,
    @required this.spell,
    @required this.mode,
    @required this.onSave,
  }) : super(key: key);

  final num index;
  final DbSpell spell;
  final DialogMode mode;
  final void Function(DbSpell move) onSave;

  @override
  AddSpellScreenState createState() => AddSpellScreenState();
}

class AddSpellScreenState extends State<AddSpellScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  AddSpellScreenState() {
    _controller = TabController(vsync: this, length: texts.length);
  }

  final List<String> texts = ['Spellbook', 'Custom Spell'];
  int tabIdx = 0;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        tabIdx = _controller.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSpellFormBuilder(
      mode: widget.mode,
      index: widget.index,
      spell: widget.spell,
      builder: (ctx, form, onSave) {
        List<Widget> actions = <Widget>[
          IconButton(
            tooltip: 'Save',
            icon: Icon(Icons.save),
            onPressed: onSave,
          ),
        ];
        var formContainer = Container(
          color: Theme.of(context).canvasColor,
          child: SingleChildScrollView(
            key: PageStorageKey<String>(texts[1]),
            padding: EdgeInsets.all(16),
            child: form,
          ),
        );
        var tabBarView = TabBarView(
          controller: _controller,
          children: <Widget>[
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: AddSpellList(
                key: PageStorageKey<String>(texts[1]),
                onSave: widget.onSave,
              ),
            ),
            formContainer,
          ],
        );
        var tabBar = Container(
          color: Theme.of(context).canvasColor,
          child: TabBar(
            controller: _controller,
            tabs: List.generate(
              texts.length,
              (i) => Tab(child: Text(texts[i])),
            ),
          ),
        );
        var appBar = AppBar(
          title: Text(
              '${widget.mode == DialogMode.Create ? 'Add' : 'Edit'} Spell'),
          actions: tabIdx == 1 || widget.mode == DialogMode.Edit ? actions : [],
        );

        var list = <Widget>[
          Expanded(
            child:
                widget.mode == DialogMode.Create ? tabBarView : formContainer,
          ),
        ];
        if (widget.mode == DialogMode.Create) {
          list.insert(0, tabBar);
        }

        return Scaffold(
          appBar: appBar,
          body: Column(
            // mainAxisSize: MainAxisSize.max,
            children: list,
          ),
        );
      },
    );
  }
}
