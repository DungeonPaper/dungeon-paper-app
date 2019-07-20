import 'package:dungeon_paper/components/card_bottom_controls.dart';
import 'package:dungeon_paper/components/confirmation_dialog.dart';
import 'package:dungeon_paper/components/tag_list.dart';
import 'package:dungeon_paper/db/spells.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

enum SpellCardMode { Addable, Editable, Fixed }

class SpellCard extends StatefulWidget {
  final num index;
  final DbSpell spell;
  final SpellCardMode mode;

  const SpellCard({
    Key key,
    @required this.spell,
    @required this.index,
    this.mode,
  }) : super(key: key);

  @override
  SpellCardState createState() => SpellCardState();
}

class SpellCardState extends State<SpellCard> {
  @override
  Widget build(BuildContext context) {
    DbSpell spell = widget.spell;
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
                        updateSpell(widget.spell);
                      },
                    )
                  ],
                  // onEdit: () => Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         fullscreenDialog: true,
                  //         builder: (ctx) => EditMoveScreen(
                  //               index: widget.index,
                  //               move: widget.spell,
                  //               mode: DialogMode.Edit,
                  //             ),
                  //       ),
                  //     ),
                  onDelete: () async => await showDialog(
                        context: context,
                        builder: (ctx) => ConfirmationDialog(
                              title: Text('Delete Spell?'),
                              okButtonText: Text('Delete Spell'),
                            ),
                      )
                          ? deleteSpell(widget.spell)
                          : null,
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
                            createSpell(widget.spell);
                            Navigator.pop(context, true);
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
