import '../../db/inventory_items.dart';
import '../../components/dialogs.dart';
import '../inventory_item_view/custom_inventory_item_form.dart';
import '../inventory_item_view/existing_inventory_items_list.dart';
import 'package:flutter/material.dart';

class AddInventoryItemContainer extends StatefulWidget {
  const AddInventoryItemContainer({
    Key key,
    @required this.item,
    @required this.mode,
    @required this.onSave,
  }) : super(key: key);

  final InventoryItem item;
  final DialogMode mode;
  final void Function(InventoryItem) onSave;

  @override
  AddInventoryItemContainerState createState() =>
      AddInventoryItemContainerState();
}

class AddInventoryItemContainerState extends State<AddInventoryItemContainer>
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
        Navigator.pop(context);
      },
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
              child: ExistingInventoryItemsList(onSave: widget.onSave),
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
          if (widget.mode == DialogMode.Create) tabBar,
          Expanded(
            child:
                widget.mode == DialogMode.Create ? tabBarView : formContainer,
          ),
        ];

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
