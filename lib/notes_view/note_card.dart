import 'package:dungeon_paper/components/card_bottom_controls.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/notes_view/edit_note_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  final num index;

  NoteCard({
    Key key,
    @required this.note,
    @required this.index,
  }) : super(key: key);

  @override
  NoteCardState createState() => NoteCardState();
}

class NoteCardState extends State<NoteCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    String desc = widget.note.description;
    return Material(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: ExpansionTile(
        title: Text(widget.note.title),
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
                onTapLink: (url) => _launchURL(url),
                data: desc.trim().length > 0
                    ? desc
                    : 'This note has no content.'),
          ),
          CardBottomControls(
            entityTypeName: 'Note',
            onEdit: () => editNote(context),
            onDelete: () => deleteCurrentNote(context),
          ),
        ],
      ),
    );
  }

  void editNote(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => EditNoteDialog(
              mode: DialogMode.Edit,
              index: widget.index,
              title: widget.note.title,
              description: widget.note.description,
              category: widget.note.category,
            ));
  }

  void deleteCurrentNote(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text('Delete Note'),
                content: const Text('Are you sure?'),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                  RaisedButton(
                      color: Colors.red[700],
                      textColor: Colors.white,
                      onPressed: () {
                        deleteNote(widget.index);
                        Navigator.pop(context);
                      },
                      child: Text('Delete')),
                ]));
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      SnackBar(
        content: const Text("Hmm... Couldn't launch URL. Is it well-formed?"),
        duration: Duration(seconds: 4),
      );
    }
  }
}
