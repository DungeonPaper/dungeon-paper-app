import '../../components/card_bottom_controls.dart';
import '../../components/confirmation_dialog.dart';
import '../../components/tags/tag_list.dart';
import '../../db/inventory_items.dart';
import '../../components/dialogs.dart';
import '../inventory_item_view/add_inventory_item_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

enum InventoryItemCardMode { Addable, Editable }

class InventoryItemCard extends StatelessWidget {
  final InventoryItem item;
  final InventoryItemCardMode mode;

  InventoryItemCard({
    Key key,
    @required this.item,
    @required this.mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num amount = item.amount;

    List<Widget> info = [];
    if (item.description != null && item.description.trim().isNotEmpty) {
      info.add(MarkdownBody(
          onTapLink: (url) => _launchURL(url), data: item.description));
    }
    if (item.tags != null && item.tags.isNotEmpty) {
      info.add(TagList(tags: item.tags));
    }

    var titleChildren = <Widget>[
      Expanded(
        child: Text(
          item.name ?? '',
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ];
    if (mode == InventoryItemCardMode.Editable) {
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
        key: PageStorageKey('inv-${item.key}'),
        title: title,
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
          mode == InventoryItemCardMode.Editable
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
                              incrItemAmount(item, -1);
                            },
                          ),
                          Text(item.amount.toString()),
                          RaisedButton(
                            shape: CircleBorder(side: BorderSide.none),
                            child: Text('+'),
                            onPressed: () {
                              incrItemAmount(item, 1);
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
                        createInventoryItem(item);
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
        builder: (ctx) => AddInventoryItemContainer(
          item: item,
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
      deleteInventoryItem(item);
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
