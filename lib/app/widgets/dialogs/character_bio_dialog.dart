import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/forms/character_bio_form.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CharacterBioDialog extends GetView<CharacterService> {
  const CharacterBioDialog({Key? key}) : super(key: key);

  Character get char => controller.current!;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: Text(S.current.characterBioDialogTitle)),
          IconButton(
            onPressed: () {
              Get.to(() => const CharacterBioForm(), preventDuplicates: false);
            },
            icon: const Icon(Icons.edit, size: 20),
          )
        ],
      ),
      contentPadding: const EdgeInsets.all(16),
      actions: [
        ElevatedButton.icon(
          icon: const Icon(Icons.check),
          label: Text(S.current.ok),
          onPressed: () => Get.back(),
          style: ButtonThemes.primaryElevated(context),
        )
      ],
      content: Obx(
        () => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
      ),
    );
  }

  void _save() {}
}
