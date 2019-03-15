import 'package:dungeon_paper/components/categorized_list.dart';
import 'package:dungeon_paper/components/search_bar.dart';
import 'package:dungeon_paper/db/inventory_items.dart';
import 'package:dungeon_paper/equipment_view/inventory_item_card.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/equipment.dart';
import 'package:flutter/material.dart';

class AddInventoryItem extends StatefulWidget {
  final Iterable<Equipment> items;
  final TextEditingController _searchController =
      TextEditingController(text: '');

  AddInventoryItem({
    Key key,
    Iterable<Equipment> items,
  })  : items = items ?? dungeonWorld.equipment.values,
        super(key: key);

  @override
  _AddInventoryItemState createState() => _AddInventoryItemState();
}

class _AddInventoryItemState extends State<AddInventoryItem> {
  String search = '';

  static String clean(String str, [String replace = '']) =>
      (str ?? '').toLowerCase().replaceAll(RegExp('[^a-z0-9]'), replace);

  @override
  Widget build(BuildContext context) {
    Map<String, List<Equipment>> itemMap = {};
    Iterable<Equipment> filtered = search.isNotEmpty
        ? widget.items
            .where((item) => clean(item.name).indexOf(clean(search)) > -1)
        : widget.items;
    filtered.forEach((item) {
      String key =
          item.name.isNotEmpty ? item.name.trim()[0].toUpperCase() : '#';
      itemMap[key] ??= [];
      itemMap[key].add(item);
    });
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: CategorizedList.builder(
            categories: itemMap.keys.toList()..sort(),
            itemCount: (key, idx) => itemMap[key].length,
            titleBuilder: (ctx, key, idx) => Text(key),
            itemBuilder: (ctx, key, idx) {
              var item = itemMap[key][idx];
              InventoryItem invItem =
                  InventoryItem({'item': item.toJSON(), 'amount': 1});
              return Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: InventoryItemCard(
                  key: PageStorageKey('add-${invItem.key}'),
                  item: invItem,
                  mode: InventoryItemCardMode.Addable,
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: Theme.of(context).canvasColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: SearchBar(
                controller: widget._searchController,
                onChanged: (val) => setState(
                      () {
                        search = val;
                      },
                    ),
              ),
            ),
            elevation: 5.0,
          ),
        ),
      ],
    );
  }
}
