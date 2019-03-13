import 'package:dungeon_paper/components/markdown_help.dart';
import 'package:dungeon_paper/db/inventory.dart';
import 'package:dungeon_paper/db/inventory_items.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_world_data/equipment.dart';
import 'package:flutter/material.dart';

class CustomInventoryItemFormBuilder extends StatefulWidget {
  final num index;
  final InventoryItem item;
  final DialogMode mode;
  final void Function(BuildContext context, Widget form, Function onSave)
      builder;
  final void Function(InventoryItem move) onUpdateItem;

  CustomInventoryItemFormBuilder({
    Key key,
    @required this.index,
    @required this.item,
    @required this.mode,
    @required this.builder,
    this.onUpdateItem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CustomInventoryItemFormBuilderState(
        index: index,
        name: item.item.name,
        description: item.item.description,
        onUpdateItem: onUpdateItem,
        mode: mode,
        builder: builder,
      );
}

class CustomInventoryItemFormBuilderState
    extends State<CustomInventoryItemFormBuilder> {
  final num index;
  final DialogMode mode;
  final void Function(InventoryItem move) onUpdateItem;
  final Widget Function(BuildContext context, Widget form, Function onSave)
      builder;
  final Map<String, TextEditingController> _controllers;

  String name;
  String description;

  CustomInventoryItemFormBuilderState({
    Key key,
    @required this.index,
    @required this.name,
    @required this.description,
    @required this.mode,
    @required this.builder,
    this.onUpdateItem,
  })  : _controllers = {
          'name': TextEditingController(text: (name ?? '').toString()),
          'description':
              TextEditingController(text: (description ?? '').toString()),
        },
        super();

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
            onChanged: (val) => _setStateValue('name', val),
            controller: _controllers['name'],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Description'),
              autofocus: mode == DialogMode.Edit,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (val) => _setStateValue('description', val),
              controller: _controllers['description'],
              // style: TextStyle(fontSize: 13.0),
              // textAlign: TextAlign.center,
            ),
          ),
          MarkdownHelp(),
        ],
      ),
    );

    return builder(
      context,
      form,
      mode == DialogMode.Create ? _createItem : _updateItem,
    );
  }

  _setStateValue(String key, String newValue) {
    setState(() {
      switch (key) {
        case 'name':
          return name = newValue;
        case 'description':
          return description = newValue;
      }
    });
  }

  _updateItem() async {
    Equipment inv = widget.item.item;
    num amount = widget.item.amount;
    InventoryItem item = InventoryItem({
      'item': inv.toJSON()..addAll({'name': name, 'description': description}),
      'amount': amount,
    });
    updateInventoryItem(index, item);
    if (onUpdateItem != null) {
      onUpdateItem(item);
    }
    Navigator.pop(context);
  }

  _createItem() async {
    InventoryItem item = InventoryItem(
      {
        'item': Equipment(
          key: name.toLowerCase().replaceAll(RegExp('[^a-z]+'), '_'),
          name: name,
          description: description,
          tags: [],
          pluralName: name + 's',
        ).toJSON(),
        'amount': widget.item.amount
      },
    );
    print(item);
    createInventoryItem(item);
    if (onUpdateItem != null) {
      onUpdateItem(item);
    }
    Navigator.pop(context);
  }
}
