import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CharacterBioDialog extends StatefulWidget {
  const CharacterBioDialog({Key? key}) : super(key: key);

  @override
  State<CharacterBioDialog> createState() => _CharacterBioDialogState();
}

class _CharacterBioDialogState extends State<CharacterBioDialog> {
  CharacterService get charService => Get.find();
  Character get char => charService.current!;

  bool edit = false;
  late final TextEditingController bioDesc;
  late final TextEditingController looks;
  late final TextEditingController alignmentName;
  late final TextEditingController alignmentValue;
  late List<TextEditingController> bonds;

  @override
  void initState() {
    super.initState();
    bioDesc = TextEditingController(text: char.bio.description);
    looks = TextEditingController(text: char.bio.looks);
    alignmentName = TextEditingController();
    alignmentValue = TextEditingController();
    bonds = [];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: Text(S.current.characterBioDialogTitle)),
          IconButton(
            onPressed: () => setState(() => edit = !edit),
            icon: const Icon(Icons.edit, size: 20),
          )
        ],
      ),
      contentPadding: const EdgeInsets.all(16),
      actions: edit
          ? [
              TextButton.icon(
                icon: const Icon(Icons.close),
                label: Text(S.current.cancel),
                onPressed: () => Get.back(),
              ),
              // const SizedBox(width: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: Text(S.current.save),
                onPressed: _save,
                style: ButtonThemes.primaryElevated(context),
              ),
            ]
          : [
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: Text(S.current.ok),
                onPressed: () => Get.back(),
                style: ButtonThemes.primaryElevated(context),
              )
            ],
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: edit
              ? <Widget>[
                  TextFormField(
                    controller: bioDesc,
                    minLines: 5,
                    maxLines: 10,
                    decoration: InputDecoration(
                      label: Text(S.current.characterBioDialogDescLabel),
                      hintText: S.current.characterBioDialogDescPlaceholder,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: looks,
                    minLines: 4,
                    maxLines: 8,
                    decoration: InputDecoration(
                      label: Text(S.current.characterBioDialogLooksLabel),
                      hintText: S.current.characterBioDialogLooksPlaceholder,
                    ),
                  ),
                ]
              : <Widget>[
                  Text(S.current.characterBioDialogDescLabel, style: textTheme.caption),
                  char.bio.description.isNotEmpty
                      ? MarkdownBody(
                          data: char.bio.description,
                          onTapLink: (_, url, __) => launch(url!),
                        )
                      : Text(S.current.noDescription),
                  const SizedBox(height: 16),
                  Text(S.current.characterBioDialogLooksLabel, style: textTheme.caption),
                  char.bio.looks.isNotEmpty
                      ? MarkdownBody(
                          data: char.bio.looks,
                          onTapLink: (_, url, __) => launch(url!),
                        )
                      : Text(S.current.noDescription),
                  const SizedBox(height: 16),
                  Text(
                      S.current.characterBioDialogAlignmentNameDisplayLabel(
                        S.current.alignment(char.bio.alignment.key),
                      ),
                      style: textTheme.caption),
                  char.bio.alignment.description.isNotEmpty
                      ? MarkdownBody(
                          data: char.bio.alignment.description,
                          onTapLink: (_, url, __) => launch(url!),
                        )
                      : Text(S.current.noDescription),
                ],
        ),
      ),
    );
  }

  void _save() {}
}
