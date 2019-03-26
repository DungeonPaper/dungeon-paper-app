import 'package:dungeon_paper/db/inventory_items.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_paper/inventory_item_screen/add_inventory_item.dart';
import 'package:dungeon_paper/inventory_item_screen/custom_inventory_item_form.dart';
import 'package:flutter/material.dart';

class InventoryItemScreen extends StatefulWidget {
  const InventoryItemScreen({
    Key key,
    @required this.item,
    @required this.mode,
  }) : super(key: key);

  final InventoryItem item;
  final DialogMode mode;

  @override
  InventoryItemScreenState createState() => InventoryItemScreenState();
}

class InventoryItemScreenState extends State<InventoryItemScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  String search = '';

  InventoryItemScreenState() {
    _controller = TabController(vsync: this, length: texts.length);
  }

  final List<String> texts = ['Item List', 'Custom Item'];
  int tabIdx = 0;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        tabIdx = _controller.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInventoryItemFormBuilder(
      mode: widget.mode,
      item: widget.item,
      builder: (ctx, form, onSave) {
        List<Widget> actions = <Widget>[
          IconButton(
            tooltip: 'Save',
            icon: Icon(Icons.save),
            onPressed: onSave,
          ),
        ];
        var formContainer = Container(
          color: Theme.of(context).canvasColor,
          child: SingleChildScrollView(
            key: PageStorageKey<String>(texts[1]),
            padding: EdgeInsets.all(16),
            child: form,
          ),
        );
        var tabBar = Container(
          color: Theme.of(context).canvasColor,
          child: TabBar(
            controller: _controller,
            tabs: List.generate(
              texts.length,
              (i) => Tab(child: Text(texts[i])),
            ),
          ),
        );
        var tabBarView = TabBarView(
          controller: _controller,
          children: <Widget>[
            Container(
              key: PageStorageKey<String>(texts[0]),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: AddInventoryItemContainer(),
            ),
            formContainer
          ],
        );
        var appBar = AppBar(
          title:
              Text('${widget.mode == DialogMode.Create ? 'Add' : 'Edit'} Item'),
          actions: tabIdx == texts.length - 1 || widget.mode == DialogMode.Edit
              ? actions
              : [],
        );

        var list = <Widget>[
          Expanded(
            child:
                widget.mode == DialogMode.Create ? tabBarView : formContainer,
          ),
        ];
        if (widget.mode == DialogMode.Create) {
          list.insert(0, tabBar);
        }

        return Scaffold(
          appBar: appBar,
          body: Column(
            // mainAxisSize: MainAxisSize.max,
            children: list,
          ),
        );
      },
    );
  }
}
