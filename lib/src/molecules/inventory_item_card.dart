import 'package:dungeon_paper/db/models/inventory_items.dart';
import 'package:dungeon_paper/src/atoms/card_bottom_controls.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/lists/tag_list.dart';
import 'package:dungeon_paper/src/scaffolds/add_inventory_item_scaffold.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

enum InventoryItemCardMode { Addable, Editable }

class InventoryItemCard extends StatelessWidget {
  final InventoryItem item;
  final InventoryItemCardMode mode;
  final void Function(InventoryItem) onSave;
  final void Function() onDelete;

  InventoryItemCard({
    Key key,
    @required this.item,
    @required this.mode,
    @required this.onSave,
    @required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amount = item.amount;

    var info = <Widget>[];
    if (item.description != null && item.description.trim().isNotEmpty) {
      info.add(MarkdownBody(
          onTapLink: (url) => _launchURL(url), data: item.description));
    }
    if (item.tags?.isNotEmpty == true) {
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
    if (item.equipped == true) {
      titleChildren.addAll([
        Chip(
          backgroundColor: Colors.orange[300],
          label: Text('Equipped'),
          padding: EdgeInsets.all(0),
          // labelPadding: EdgeInsets.all(0),
        ),
        SizedBox(width: 10),
      ]);
    }
    if (mode == InventoryItemCardMode.Editable) {
      titleChildren.add(Text('x$amount'));
    }
    var title = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: titleChildren,
    );
    return Card(
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        key: PageStorageKey('inv-${item.key}'),
        title: title,
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.equipped ? 'Equipped' : 'Unequiped'),
                Switch(
                  value: item.equipped,
                  onChanged: (val) {
                    final copy = item.copy();
                    copy.equipped = val;
                    onSave?.call(copy);
                  },
                )
              ],
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
                              var copy = _incrAmount(item, -1);
                              onSave?.call(copy);
                            },
                          ),
                          Text(item.amount.toString()),
                          RaisedButton(
                            shape: CircleBorder(side: BorderSide.none),
                            child: Text('+'),
                            onPressed: () {
                              var copy = _incrAmount(item, 1);
                              onSave?.call(copy);
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
                        onSave?.call(item);
                        Get.back();
                      },
                    ),
                  ),
                )
        ],
        onExpansionChanged: (value) => analytics.logEvent(
          name: Events.ExpandInventoryItemCard,
          parameters: {'state': value.toString()},
        ),
      ),
    );
  }

  void editInventoryItem(BuildContext context) {
    Get.to(
      AddInventoryItemScaffold(
        item: item,
        mode: DialogMode.Edit,
        onSave: onSave,
      ),
    );
  }

  void deleteCurrentInventoryItem(BuildContext context) async {
    if (await showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
          title: const Text('Delete Inventory Item'),
          text: const Text('Are you sure?'),
          cancelButtonText: Text('Cancel')),
    )) {
      onDelete?.call();
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar(
        'Hmm...',
        "Couldn't launch URL. Is it well-formed?",
        duration: SnackBarDuration.short,
      );
    }
  }

  InventoryItem _incrAmount(InventoryItem item, num amount) {
    var copy = item.copy();
    var amt = clamp(copy.amount + amount, 0, double.infinity);
    copy.amount = amt.toInt();
    return copy;
  }
}
