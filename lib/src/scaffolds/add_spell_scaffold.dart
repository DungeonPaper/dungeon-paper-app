import 'package:dungeon_paper/db/models/spells.dart';
import 'package:dungeon_paper/src/builders/custom_spell_form_builder.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/lists/add_spell_list.dart';
import 'package:flutter/material.dart';

class AddSpellScaffold extends StatefulWidget {
  const AddSpellScaffold({
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
  AddSpellScaffoldState createState() => AddSpellScaffoldState();
}

class AddSpellScaffoldState extends State<AddSpellScaffold>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  AddSpellScaffoldState() {
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
      onSave: widget.onSave,
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
