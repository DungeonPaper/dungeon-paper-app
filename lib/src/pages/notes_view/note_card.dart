import 'package:dungeon_paper/db/models/notes.dart';
import 'package:dungeon_paper/src/atoms/card_bottom_controls.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/scaffolds/edit_note_scaffold.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  final void Function(Note) onSave;
  final void Function() onDelete;

  NoteCard({
    Key key,
    @required this.note,
    @required this.onSave,
    @required this.onDelete,
  }) : super(key: key);

  @override
  NoteCardState createState() => NoteCardState();
}

class NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    var desc = widget.note.description;
    return Card(
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        title: Text(widget.note.title),
        onExpansionChanged: (value) => analytics.logEvent(
          name: Events.ExpandNoteCard,
          parameters: {'state': value.toString()},
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: MarkdownBody(
                onTapLink: (url) => _launchURL(url),
                data: desc.trim().isNotEmpty
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
          onSave: (note) {
            if (widget.onSave != null) {
              widget.onSave(note);
            }
          },
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
        ) ==
        true) {
      if (widget.onDelete != null) {
        widget.onDelete();
      }
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
