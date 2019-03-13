import 'package:dungeon_paper/components/card_bottom_controls.dart';
import 'package:dungeon_paper/components/confirmation_dialog.dart';
import 'package:dungeon_paper/db/spells.dart';
import 'package:dungeon_world_data/spell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

enum SpellCardMode { Addable, Editable, Fixed }

class SpellCard extends StatefulWidget {
  final num index;
  final Spell spell;
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
    Spell spell = widget.spell;

    return Material(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: ExpansionTile(
        key: PageStorageKey(spell.key),
        title: Text(spell.name),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: MarkdownBody(data: spell.description),
          ),
          widget.mode == SpellCardMode.Editable
              ? CardBottomControls(
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
                            ? deleteSpell(widget.index)
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
}
