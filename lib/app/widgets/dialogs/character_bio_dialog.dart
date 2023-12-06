import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/modules/BioForm/controllers/bio_form_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/utils/markdown_styles.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CharacterBioDialog extends GetView with CharacterServiceMixin {
  const CharacterBioDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // final maxContentHeight = MediaQuery.of(context).size.height - 250;

    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: Text(tr.bio.dialog.title)),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.bio, arguments: BioFormArguments(character: character));
            },
            icon: const Icon(Icons.edit, size: 20),
          )
        ],
      ),
      contentPadding: const EdgeInsets.all(16),
      actions: DialogControls.done(context, () => Get.back()),
      content: Obx(
        () => SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              // shrinkWrap: true,
              children: [
                Text(tr.bio.dialog.description.label, style: textTheme.bodySmall),
                char.bio.description.isNotEmpty
                    ? MarkdownBody(
                        data: char.bio.description,
                        onTapLink: (_, url, __) => launchUrl(Uri.parse(url!)),
                        styleSheet: MarkdownStyles.of(context),
                      )
                    : Text(tr.generic.noDescription),
                const SizedBox(height: 16),
                Text(tr.bio.dialog.looks.label, style: textTheme.bodySmall),
                char.bio.looks.isNotEmpty
                    ? Text(char.bio.looks, style: textTheme.bodyLarge)
                    // TODO broken...?!
                    // ? ConstrainedBox(
                    //     constraints: BoxConstraints.loose(Size.fromHeight(maxContentHeight)),
                    // ? SizedBox(
                    //     height: 120,
                    //     width: MediaQuery.of(context).size.width - 100,
                    //     // ? IntrinsicWidth(
                    //     //     child: IntrinsicHeight(
                    //     child:
                    // ? MarkdownBody(
                    //     shrinkWrap: true,
                    //     // fitContent: true,
                    //     data: char.bio.looks,
                    //     onTapLink: (_, url, __) => launch(url!),
                    //   )
                    // ,
                    //   )
                    // )
                    : Text(tr.generic.noDescription),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      tr.bio.dialog.alignment.label,
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(width: 4),
                    IconTheme.merge(
                      data: IconThemeData(size: 14, color: textTheme.bodySmall!.color!),
                      child: Icon(char.bio.alignment.icon),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      tr.alignment.name(char.bio.alignment.key),
                      style: textTheme.bodySmall,
                    ),
                  ],
                ),
                char.bio.alignment.description.isNotEmpty
                    ? MarkdownBody(
                        data: char.bio.alignment.description,
                        onTapLink: (_, url, __) => launchUrl(Uri.parse(url!)),
                      )
                    : Text(tr.generic.noDescription),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
