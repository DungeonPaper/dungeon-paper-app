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
    var hasBio = character.bio?.isNotEmpty == true;
    var hasClsDescr = character.mainClass?.description?.isNotEmpty == true;
    return SimpleDialog(
      title: Text('Biography'),
      contentPadding: const EdgeInsets.all(24),
      children: [
        if (hasBio) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              'Character biography',
              textScaleFactor: 1.1,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          MarkdownBody(
            data: character.bio,
          ),
        ],
        if (hasBio && hasClsDescr) SizedBox(height: 30),
        if (hasClsDescr) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              '${character.mainClass.name} description',
              textScaleFactor: 1.1,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          MarkdownBody(
            data: character.mainClass.description,
          ),
        ]
      ],
    );
  }
}
