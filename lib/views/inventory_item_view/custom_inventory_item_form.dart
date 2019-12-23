import '../../components/markdown_help.dart';
import '../../components/tags/editable_tag_list.dart';
import '../../db/inventory_items.dart';
import '../../components/dialogs.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:flutter/material.dart';

class CustomInventoryItemFormBuilder extends StatefulWidget {
  final InventoryItem item;
  final DialogMode mode;
  final Widget Function(BuildContext context, Widget form, Function onSave)
      builder;
  final void Function(InventoryItem move) onUpdateItem;

  CustomInventoryItemFormBuilder({
    Key key,
    @required this.item,
    @required this.mode,
    @required this.builder,
    this.onUpdateItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomInventoryItemFormBuilderState();
}

class CustomInventoryItemFormBuilderState
    extends State<CustomInventoryItemFormBuilder> {
  Map<String, TextEditingController> _controllers;
  List<Tag> tags;

  @override
  void initState() {
    _controllers = {
      'name': TextEditingController(text: (widget.item.name ?? '').toString()),
      'description': TextEditingController(
          text: (widget.item.description ?? '').toString()),
      'amount':
          TextEditingController(text: (widget.item.amount ?? '1').toString()),
    };
    tags = List.from(widget.item.tags ?? []);
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
            decoration: InputDecoration(hintText: 'Item Name'),
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
            onSave: (tag, idx) {
              setState(() {
                if (idx == tags.length) {
                  tags.add(tag);
                } else {
                  tags[idx] = tag;
                }
              });
            },
            onDelete: (tag, idx) => setState(() => tags.removeAt(idx)),
          ),
          MarkdownHelp(),
        ],
      ),
    );

    return widget.builder(
      context,
      form,
      widget.mode == DialogMode.Create ? _createItem : _updateItem,
    );
  }

  _updateItem() async {
    InventoryItem item = widget.item;
    item.name = _controllers['name'].text;
    item.description = _controllers['description'].text;
    item.pluralName = _controllers['name'].text + 's';
    item.amount = int.tryParse(_controllers['amount'].text);
    item.tags = tags;
    updateInventoryItem(item);
    if (widget.onUpdateItem != null) {
      widget.onUpdateItem(item);
    }
    Navigator.pop(context);
  }

  _createItem() async {
    InventoryItem item = InventoryItem(
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
    createInventoryItem(item);
    if (widget.onUpdateItem != null) {
      widget.onUpdateItem(item);
    }
    Navigator.pop(context);
  }
}
