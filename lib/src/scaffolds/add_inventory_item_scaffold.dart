import 'package:dungeon_paper/db/models/inventory_items.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/lists/existing_inventory_items_list.dart';
import 'package:dungeon_paper/src/scaffolds/custom_inventory_item_form.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInventoryItemScaffold extends StatefulWidget {
  const AddInventoryItemScaffold({
    Key key,
    @required this.item,
    @required this.mode,
    @required this.onSave,
  }) : super(key: key);

  final InventoryItem item;
  final DialogMode mode;
  final void Function(InventoryItem) onSave;

  @override
  AddInventoryItemScaffoldState createState() =>
      AddInventoryItemScaffoldState();
}

class AddInventoryItemScaffoldState extends State<AddInventoryItemScaffold>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  String search = '';

  final List<String> texts = ['Item List', 'Custom Item'];
  int tabIdx = 0;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: texts.length)
      ..addListener(() {
        setState(() {
          tabIdx = _controller.index;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInventoryItemForm(
      mode: widget.mode,
      item: widget.item,
      onSave: (item) {
        if (widget.onSave != null) {
          widget.onSave(item);
        }
        Get.back();
      },
      builder: (ctx, form, onSave) {
        var actions = <Widget>[
          IconButton(
            tooltip: 'Save',
            icon: Icon(Icons.save),
            onPressed: onSave,
          ),
        ];
        var formContainer = Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SingleChildScrollView(
            key: PageStorageKey<String>(texts[1]),
            padding: EdgeInsets.all(16),
            child: form,
          ),
        );
        var tabBar = TabBar(
          controller: _controller,
          tabs: List.generate(
            texts.length,
            (i) => Tab(child: Text(texts[i])),
          ),
        );
        var tabBarView = TabBarView(
          controller: _controller,
          children: <Widget>[
            Container(
              key: PageStorageKey<String>(texts[0]),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ExistingInventoryItemsList(onSave: widget.onSave),
            ),
            formContainer
          ],
        );

        var list = <Widget>[
          if (widget.mode == DialogMode.Create) tabBar,
          Expanded(
            child:
                widget.mode == DialogMode.Create ? tabBarView : formContainer,
          ),
        ];

        return ScaffoldWithElevation(
          useElevation: false,
          wrapWithScrollable: false,
          elevation: 0.0,
          title:
              Text('${widget.mode == DialogMode.Create ? 'Add' : 'Edit'} Item'),
          actions: tabIdx == texts.length - 1 || widget.mode == DialogMode.Edit
              ? actions
              : [],
          body: Column(
            children: list,
          ),
        );
      },
    );
  }
}
