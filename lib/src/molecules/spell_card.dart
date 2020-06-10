import 'package:dungeon_paper/db/models/spells.dart';
import 'package:dungeon_paper/src/atoms/card_bottom_controls.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/lists/tag_list.dart';
import 'package:dungeon_paper/src/scaffolds/add_spell_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

enum SpellCardMode { Addable, Editable, Fixed }

class SpellCard extends StatefulWidget {
  final num index;
  final DbSpell spell;
  final SpellCardMode mode;
  final void Function(DbSpell) onSave;
  final void Function() onDelete;

  const SpellCard({
    Key key,
    @required this.spell,
    @required this.index,
    this.mode,
    @required this.onSave,
    @required this.onDelete,
  }) : super(key: key);

  @override
  SpellCardState createState() => SpellCardState();
}

class SpellCardState extends State<SpellCard> {
  @override
  Widget build(BuildContext context) {
    var spell = widget.spell;
    Widget name = Text(spell.name);

    return Material(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: ExpansionTile(
        key: PageStorageKey(spell.key),
        title: widget.spell.prepared != null && widget.spell.prepared
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  name,
                  Chip(
                    backgroundColor: Colors.lightBlue[100],
                    label: Text('Prepared'),
                    padding: EdgeInsets.all(0),
                    // labelPadding: EdgeInsets.all(0),
                  )
                ],
              )
            : name,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: MarkdownBody(data: spell.description),
          ),
          widget.spell.tags != null && widget.spell.tags.isNotEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TagList(tags: widget.spell.tags),
                  ),
                )
              : SizedBox.shrink(),
          widget.mode == SpellCardMode.Editable
              ? CardBottomControls(
                  leading: <Widget>[
                    Text(widget.spell.prepared ? 'Prepared' : 'Unprepared'),
                    Switch(
                      value: spell.prepared,
                      onChanged: (val) {
                        spell.prepared = val;
                        if (widget.onSave != null) {
                          widget.onSave(spell);
                        }
                      },
                    )
                  ],
                  onEdit: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (ctx) => AddSpellScaffold(
                        index: widget.index,
                        spell: widget.spell,
                        onSave: (spell) {
                          if (widget.onSave != null) {
                            widget.onSave(spell);
                          }
                          Navigator.pop(ctx);
                        },
                        mode: DialogMode.Edit,
                      ),
                    ),
                  ),
                  onDelete: () async {
                    if (await showDialog(
                      context: context,
                      builder: (ctx) => ConfirmationDialog(
                        title: Text('Delete Spell?'),
                        okButtonText: Text('Delete Spell'),
                      ),
                    )) {
                      if (widget.onDelete != null) {
                        widget.onDelete();
                      }
                    }
                  },
                )
              : widget.mode == SpellCardMode.Addable
                  ? Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 10),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorLight,
                          child: Text('Add Spell'),
                          onPressed: () {
                            if (widget.onSave != null) {
                              widget.onSave(widget.spell);
                            }
                          },
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
        ],
      ),
    );
  }

  void togglePrepared(bool state) {}
}
