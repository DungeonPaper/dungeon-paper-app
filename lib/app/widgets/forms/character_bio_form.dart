import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CharacterBioForm extends StatefulWidget {
  const CharacterBioForm({Key? key}) : super(key: key);

  @override
  State<CharacterBioForm> createState() => _CharacterBioFormState();
}

class _CharacterBioFormState extends State<CharacterBioForm> {
  CharacterService get charService => Get.find();
  Character get char => charService.current!;

  late final TextEditingController bioDesc;
  late final TextEditingController looks;
  late final String alignmentName;
  late final TextEditingController alignmentValue;
  late List<TextEditingController> bonds;

  @override
  void initState() {
    super.initState();
    bioDesc = TextEditingController(text: char.bio.description);
    looks = TextEditingController(text: char.bio.looks);
    alignmentName = char.bio.alignment.key;
    alignmentValue = TextEditingController();
    bonds = [];
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ConfirmExitView(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.characterBioDialogTitle),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: DwColors.success,
          onPressed: _save,
          label: Text(S.current.save),
          icon: const Icon(Icons.save),
        ),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          TextFormField(
            controller: bioDesc,
            minLines: 5,
            maxLines: 10,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              label: Text(S.current.characterBioDialogDescLabel),
              hintText: S.current.characterBioDialogDescPlaceholder,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: looks,
            minLines: 4,
            maxLines: 8,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              label: Text(S.current.characterBioDialogLooksLabel),
              hintText: S.current.characterBioDialogLooksPlaceholder,
            ),
          ),
          const SizedBox(height: 24),
          SelectBox<String>(
            value: alignmentName,
            items: AlignmentValue.allKeys
                .map(
                  (a) => DropdownMenuItem<String>(
                    value: a,
                    child: Text(S.current.alignment(a)),
                  ),
                )
                .toList(),
            onChanged: (v) => setState(() {
              alignmentName = v!;
            }),
            isExpanded: true,
            label: Text(S.current.characterBioDialogAlignmentNameLabel),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: alignmentValue,
            minLines: 4,
            maxLines: 8,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              label: Text(S.current.characterBioDialogAlignmentDescriptionLabel),
              hintText: S.current.characterBioDialogAlignmentDescriptionPlaceholder,
            ),
          ),
        ]),
      ),
    );
  }

  void _save() {
    final char = charService.current!;
    charService.updateCharacter(char.copyWith(
      bio: char.bio.copyWith(
        description: bioDesc.text,
        looks: looks.text.replaceAll(RegExp('\\s*\n'), '  \n'),
        alignment: char.bio.alignment.copyWith(
          description: alignmentValue.text,
          key: alignmentName,
        ),
      ),
    ));
    Get.back();
  }
}
