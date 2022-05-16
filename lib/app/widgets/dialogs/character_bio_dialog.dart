import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/modules/BioForm/controllers/bio_form_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CharacterBioDialog extends GetView with CharacterServiceMixin {
  const CharacterBioDialog({Key? key}) : super(key: key);

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
              Get.toNamed(Routes.bio, arguments: BioFormArguments(character: character));
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
              Row(
                children: [
                  Text(
                    S.current.characterBioDialogAlignmentNameDisplayLabel,
                    style: textTheme.caption,
                  ),
                  const SizedBox(width: 4),
                  IconTheme.merge(
                    data: IconThemeData(size: 14, color: textTheme.caption!.color!),
                    child: char.bio.alignment.icon,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    S.current.alignment(char.bio.alignment.key),
                    style: textTheme.caption,
                  ),
                ],
              ),
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
}
