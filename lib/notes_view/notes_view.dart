import 'package:dungeon_paper/db/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class NotesView extends StatelessWidget {
  final DbCharacter character;

  NotesView({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.from(
        character.notes.map(
          (note) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: new NoteCard(note: note),
              ),
        ),
      ),
    );
  }
}

class NoteCardState extends State<NoteCard> {
  bool expanded;
  Map note;
  void Function(bool state) onExpansionChange;
  NoteCardState(
      {@required this.expanded, @required this.note, this.onExpansionChange});

  @override
  Widget build(BuildContext context) {
    String desc = note['description'];
    return Material(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: ExpansionTile(
        title: Text(note['title']),
        initiallyExpanded: expanded,
        onExpansionChanged: (s) {
          setState(() {
            expanded = !expanded;
          });
        },
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: MarkdownBody(
                data: desc.trim().length > 0
                    ? desc
                    : 'This note has no content.'),
          ),
        ],
      ),
    );
  }
}

class NoteCard extends StatefulWidget {
  final Map note;
  NoteCard({Key key, @required this.note}) : super(key: key);

  @override
  NoteCardState createState() => NoteCardState(note: note, expanded: false);
}
