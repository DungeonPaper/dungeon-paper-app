import 'package:dungeon_paper/db/models/inventory_items.dart';
import 'package:dungeon_paper/src/atoms/markdown_help.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/molecules/editable_tag_list.dart';
import 'package:uuid/uuid.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:flutter/material.dart';

class CustomInventoryItemForm extends StatefulWidget {
  final InventoryItem item;
  final DialogMode mode;
  final Widget Function(BuildContext context, Widget form, Function() onSave)
      builder;
  final void Function(InventoryItem move) onSave;

  CustomInventoryItemForm({
    Key key,
    this.item,
    @required this.mode,
    @required this.builder,
    this.onSave,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomInventoryItemFormState();
}

class CustomInventoryItemFormState extends State<CustomInventoryItemForm> {
  Map<String, TextEditingController> _controllers;
  List<Tag> tags;

  @override
  void initState() {
    final item = widget.item ?? InventoryItem(key: Uuid().v4());
    _controllers = WidgetUtils.textEditingControllerMap(map: {
      'name': EditingControllerConfig(defaultValue: item.name ?? ''),
      'description':
          EditingControllerConfig(defaultValue: item.description ?? ''),
      'amount':
          EditingControllerConfig(defaultValue: item.amount?.toString() ?? ''),
    });
    tags = List.from(item.tags ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget form = Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Item Name'),
            autocorrect: true,
            textCapitalization: TextCapitalization.words,
            controller: _controllers['name'],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Description (Markdown supported)'),
              autofocus: widget.mode == DialogMode.Edit,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              controller: _controllers['description'],
              // style: TextStyle(fontSize: 13.0),
              // textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 10),
          TextField(
            decoration: InputDecoration(labelText: 'Item Amount'),
            keyboardType: TextInputType.number,
            controller: _controllers['amount'],
          ),
          EditableTagList(
            tags: tags,
            onSave: (updated) => setState(() {
              tags = updated;
            }),
          ),
          MarkdownHelp(),
        ],
      ),
    );

    if (widget.builder != null) {
      return widget.builder(
        context,
        form,
        widget.mode == DialogMode.Create ? _createItem : _updateItem,
      );
    }

    return form;
  }

  void _updateItem() async {
    var item = widget.item;
    item.name = _controllers['name'].text;
    item.description = _controllers['description'].text;
    item.pluralName = _controllers['name'].text + 's';
    item.amount = int.tryParse(_controllers['amount'].text);
    item.tags = tags;
    if (widget.onSave != null) {
      widget.onSave(item);
    }
  }

  void _createItem() async {
    var item = InventoryItem(
      key: _controllers['name']
          .text
          .toLowerCase()
          .replaceAll(RegExp('[^a-z]+'), '_'),
      name: _controllers['name'].text,
      description: _controllers['description'].text,
      tags: tags,
      pluralName: _controllers['name'].text + 's',
      amount: int.tryParse(_controllers['amount'].text) ?? 1,
    );
    if (widget.onSave != null) {
      widget.onSave(item);
    }
  }
}
