import 'package:dungeon_paper/db/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class BiographyDialog extends StatelessWidget {
  final Character character;

  const BiographyDialog({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Biography'),
      contentPadding: const EdgeInsets.all(24),
      children: [
        if (character.bio?.isNotEmpty == true) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text('Character biography',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          MarkdownBody(
            data: character.bio,
          ),
        ],
        if (character.mainClass?.description?.isNotEmpty == true) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text('${character.mainClass.name} description',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          MarkdownBody(
            data: character.mainClass.description,
          ),
        ]
      ],
    );
  }
}
