import 'package:dungeon_paper/components/card_bottom_controls.dart';
import 'package:dungeon_paper/components/confirmation_dialog.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_paper/notes_view/edit_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class NoteCard extends StatefulWidget {
  final Note note;

  NoteCard({
    Key key,
    @required this.note,
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
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => EditNoteScreen(
              note: widget.note,
              mode: DialogMode.Edit,
            ),
      ),
    );
  }

  void deleteCurrentNote(BuildContext context) async {
    if (await showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
          title: const Text('Delete Note'),
          text: const Text('Are you sure?'),
          cancelButtonText: Text('Cancel')),
    )) {
      deleteNote(widget.note);
    }
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
