import 'package:dungeon_paper/components/card_bottom_controls.dart';
import 'package:dungeon_paper/components/confirmation_dialog.dart';
import 'package:dungeon_paper/db/inventory_items.dart';
import 'package:dungeon_paper/dialogs.dart';
import 'package:dungeon_paper/inventory_item_screen/add_inventory_screen.dart';
import 'package:dungeon_world_data/equipment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

enum InventoryItemCardMode { Addable, Editable }

class InventoryItemCard extends StatefulWidget {
  final InventoryItem item;
  final InventoryItemCardMode mode;

  InventoryItemCard({
    Key key,
    @required this.item,
    @required this.mode,
  }) : super(key: key);

  @override
  InventoryItemCardState createState() => InventoryItemCardState();
}

class InventoryItemCardState extends State<InventoryItemCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    Equipment item = widget.item.item;
    num amount = widget.item.amount;

    List<Widget> info = [];
    if (item.description != null && item.description.trim().isNotEmpty) {
      info.add(MarkdownBody(
          onTapLink: (url) => _launchURL(url), data: item.description));
    }
    if (item.tags != null && item.tags.isNotEmpty) {
      info.add(
        Wrap(
          children: item.tags
              .map(
                (tag) => Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Chip(
                        label: Text(
                          tag.hasValues
                              ? tag.values.keys
                                  .map((k) => '$k: ${tag.values[k]}')
                                  .join(' ')
                              : tag.name,
                        ),
                      ),
                    ),
              )
              .toList(),
        ),
      );
    }

    var titleChildren = <Widget>[
      Expanded(
        child: Text(
          widget.item.item?.name ?? '',
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];
    if (widget.mode == InventoryItemCardMode.Editable) {
      titleChildren.add(Text('x$amount'));
    }
    var title = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: titleChildren,
    );
    return Material(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: ExpansionTile(
        key: PageStorageKey('inv-${widget.item.key}'),
        title: title,
        initiallyExpanded: expanded == true,
        onExpansionChanged: (s) {
          setState(() {
            expanded = !expanded;
          });
        },
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: info,
            ),
          ),
          widget.mode == InventoryItemCardMode.Editable
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          RaisedButton(
                            shape: CircleBorder(side: BorderSide.none),
                            child: Text('-'),
                            onPressed: () {
                              incrItemAmount(widget.item, -1);
                            },
                          ),
                          Text(widget.item.amount.toString()),
                          RaisedButton(
                            shape: CircleBorder(side: BorderSide.none),
                            child: Text('+'),
                            onPressed: () {
                              incrItemAmount(widget.item, 1);
                            },
                          )
                        ],
                      ),
                    ),
                    CardBottomControls(
                      entityTypeName: 'Inventory Item',
                      onEdit: () => editInventoryItem(context),
                      onDelete: () => deleteCurrentInventoryItem(context),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: RaisedButton(
                      child: Text('Add Item'),
                      color: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        createInventoryItem(widget.item);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
        ],
      ),
    );
  }

  void editInventoryItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => InventoryItemScreen(
              item: widget.item,
              mode: DialogMode.Edit,
            ),
      ),
    );
  }

  void deleteCurrentInventoryItem(BuildContext context) async {
    if (await showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
          title: const Text('Delete InventoryItem'),
          text: const Text('Are you sure?'),
          cancelButtonText: Text('Cancel')),
    )) {
      deleteInventoryItem(widget.item);
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      SnackBar(
        content: const Text("Hmm... Couldn't launch URL. Is it well-formed?"),
        duration: Duration(seconds: 4),
      );
    }
  }
}
