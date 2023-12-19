import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTagDialog extends StatefulWidget {
  const AddTagDialog({
    super.key,
    this.tag,
    this.onSave,
  });

  final dw.Tag? tag;
  final void Function(dw.Tag tag)? onSave;

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  final RepositoryProvider repo = Get.find();
  late final TextEditingController name;
  late final TextEditingController desc;
  late final TextEditingController value;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.tag?.name ?? '');
    desc = TextEditingController(text: widget.tag?.description ?? '');
    value = TextEditingController(text: widget.tag?.value?.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(child: Text(tr.generic.createEntity(tr.entity(tn(dw.Tag))))),
          MenuButton<dw.Tag>(
            items: [
              for (final tag in allTags)
                MenuEntry<dw.Tag>(
                  label: Text(tr.tags.copyFrom(toTitleCase(tag.name))),
                  value: tag,
                  onSelect: () {
                    setState(() {
                      name.text = tag.name;
                      desc.text = tag.description;
                      value.text = tag.value?.toString() ?? '';
                    });
                  },
                )
            ],
            child: const Icon(Icons.list),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: name,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              filled: true,
              label: Text(
                tr.generic.entityName(tr.entity(tn(dw.Tag))),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: value,
            textCapitalization: TextCapitalization.sentences,
            minLines: 1,
            maxLines: 3,
            decoration: InputDecoration(
              filled: true,
              label: Text(
                tr.generic.entityValue(tr.entity(tn(dw.Tag))),
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: desc,
            textCapitalization: TextCapitalization.sentences,
            minLines: 1,
            maxLines: 3,
            decoration: InputDecoration(
              filled: true,
              label: Text(
                tr.generic.entityDescription(tr.entity(tn(dw.Tag))),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onSave?.call(createTag());
            Get.back();
          },
          child: Text(tr.generic.save),
        ),
      ],
    );
  }

  dw.Tag createTag() => dw.Tag(
        name: name.text,
        description: desc.text,
        value: tryParse(value.text),
      );

  List<dw.Tag> get allTags =>
      {...repo.my.tags.values, ...repo.builtIn.tags.values}.toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

  dynamic tryParse(String text) {
    if (RegExp(r'[a-z]').hasMatch(text)) {
      return text;
    }
    if (RegExp(r'[.]').hasMatch(text)) {
      return double.tryParse(text);
    }

    return int.tryParse(text);
  }
}
