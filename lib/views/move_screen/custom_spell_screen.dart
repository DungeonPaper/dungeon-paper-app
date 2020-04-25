import 'package:dungeon_paper/components/tags/editable_tag_list.dart';
import 'package:dungeon_paper/db/spells.dart';
import 'package:dungeon_world_data/tag.dart';
import '../../components/markdown_help.dart';
import '../../components/dialogs.dart';
import 'package:flutter/material.dart';

class CustomSpellFormBuilder extends StatefulWidget {
  final num index;
  final DbSpell spell;
  final DialogMode mode;
  final Widget Function(BuildContext context, Widget form, Function() onSave)
      builder;
  final void Function(DbSpell move) onSave;

  CustomSpellFormBuilder({
    Key key,
    @required this.index,
    @required this.spell,
    @required this.mode,
    @required this.builder,
    this.onSave,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomSpellFormBuilderState();
}

class CustomSpellFormBuilderState extends State<CustomSpellFormBuilder> {
  String name;
  String description;
  String explanation;
  Map<String, TextEditingController> _controllers;
  List<Tag> tags;

  @override
  void initState() {
    _controllers = {
      'name': TextEditingController(text: (widget.spell.name ?? '').toString()),
      'description': TextEditingController(
          text: (widget.spell.description ?? '').toString()),
    };
    name = _controllers['name'].text;
    description = _controllers['description'].text;
    tags = widget.spell.tags.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget form = Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: 'Spell Name'),
            autocorrect: true,
            textCapitalization: TextCapitalization.words,
            onChanged: (val) => _setStateValue('name', val),
            controller: _controllers['name'],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Description'),
              autofocus: widget.mode == DialogMode.Edit,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (val) => _setStateValue('description', val),
              controller: _controllers['description'],
              // style: TextStyle(fontSize: 13.0),
              // textAlign: TextAlign.center,
            ),
          ),
          EditableTagList(
            tags: tags,
            onSave: (tag, idx) {
              setState(() {
                if (idx == tags.length) {
                  tags.add(tag);
                } else {
                  tags[idx] = tag;
                }
              });
            },
            onDelete: (tag, idx) => setState(() => tags.removeAt(idx)),
          ),
          MarkdownHelp(),
        ],
      ),
    );

    return widget.builder(context, form, _saveSpell);
  }

  _setStateValue(String key, String newValue) {
    setState(() {
      switch (key) {
        case 'name':
          name = newValue;
          return;
        case 'description':
          description = newValue;
          return;
        case 'explanation':
          explanation = newValue;
          return;
      }
    });
  }

  void _saveSpell() async {
    var spell = _generateSpell();
    if (widget.onSave != null) {
      widget.onSave(spell);
    }
  }

  DbSpell _generateSpell() {
    return DbSpell(
      key: widget.spell.key,
      name: name,
      description: description,
      level: widget.spell.level,
      prepared: widget.spell.prepared,
      tags: tags,
    );
  }
}
