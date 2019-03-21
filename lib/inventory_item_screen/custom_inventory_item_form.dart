import 'package:dungeon_paper/components/markdown_help.dart';
import 'package:dungeon_paper/db/inventory_items.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_world_data/equipment.dart';
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

  String name;
  String description;
  String amount;

  @override
  void initState() {
    _controllers = {
      'name': TextEditingController(text: (widget.item.item.name ?? '').toString()),
      'description': TextEditingController(
          text: (widget.item.item.description ?? '').toString()),
      'amount':
          TextEditingController(text: (widget.item.amount ?? '').toString()),
    };
    name =_controllers['name'].text;
    description =_controllers['description'].text;
    amount =_controllers['amount'].text;
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
            onChanged: (val) => _setStateValue('name', val),
            controller: _controllers['name'],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Description'),
              autofocus: widget.mode == DialogMode.Edit,
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
          SizedBox(width: 10,),
          TextField(
            decoration: InputDecoration(labelText: 'Item Amount'),
            onChanged: (val) => _setStateValue('amount', val),
            keyboardType: TextInputType.number,
            controller: _controllers['amount'],
          ),
        ],
      ),
    );

    return widget.builder(
      context,
      form,
      widget.mode == DialogMode.Create ? _createItem : _updateItem,
    );
  }

  _setStateValue(String key, String newValue) {
    setState(() {
      switch (key) {
        case 'name':
          return name = newValue;
        case 'description':
          return description = newValue;
        case 'amount':
          return amount = newValue;
      }
    });
  }

  _updateItem() async {
    Equipment inv = widget.item.item;
    InventoryItem item = InventoryItem({
      'item': inv.toJSON()..addAll({'name': name, 'description': description, 'amount': int.tryParse(amount) ?? 1}),
      'amount': int.tryParse(amount) ?? 1,
    });
    updateInventoryItem(item);
    if (widget.onUpdateItem != null) {
      widget.onUpdateItem(item);
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
        'amount': int.tryParse(amount) ?? 1,
      },
    );
    print(item);
    createInventoryItem(item);
    if (widget.onUpdateItem != null) {
      widget.onUpdateItem(item);
    }
    Navigator.pop(context);
  }
}
