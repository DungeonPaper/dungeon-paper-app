import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

class AddTagDialog extends StatefulWidget {
  const AddTagDialog({
    Key? key,
    this.tag,
    this.onSave,
  }) : super(key: key);

  final dw.Tag? tag;
  final void Function(dw.Tag tag)? onSave;

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  final RepositoryService repo = Get.find();
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
          Expanded(child: Text(S.current.createGeneric(dw.Tag))),
          PopupMenuButton<dw.Tag>(
            child: const Icon(Icons.list),
            onSelected: (tag) {
              setState(() {
                name.text = tag.name;
                desc.text = tag.description;
                value.text = tag.value?.toString() ?? '';
              });
            },
            itemBuilder: (ctx) => [
              for (final tag in {...repo.my.tags.values, ...repo.builtIn.tags.values})
                PopupMenuItem<dw.Tag>(
                  child: Text(S.current.tagCopyFrom(toTitleCase(tag.name))),
                  value: tag,
                )
            ],
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
                S.current.genericNameField(
                  S.current.entity(dw.Tag),
                ),
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
                S.current.genericValueField(
                  S.current.entity(dw.Tag),
                ),
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
                S.current.genericDescriptionField(
                  S.current.entity(dw.Tag),
                ),
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
          child: Text(S.current.save),
        ),
      ],
    );
  }

  dw.Tag createTag() => dw.Tag(
        name: name.text,
        description: desc.text,
        value: tryParse(value.text),
      );

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
