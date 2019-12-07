import '../../components/categorized_list.dart';
import '../../components/search_bar.dart';
import '../../db/inventory_items.dart';
import '../equipment_view/inventory_item_card.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/equipment.dart';
import 'package:flutter/material.dart';

class ExistingInventoryItemsList extends StatelessWidget {
  final Iterable<Equipment> items;

  const ExistingInventoryItemsList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddInventoryItem(items: items);
  }
}

class AddInventoryItem extends StatefulWidget {
  final Iterable<Equipment> items;
  final TextEditingController _searchController =
      TextEditingController(text: '');

  AddInventoryItem({
    Key key,
    Iterable<Equipment> items,
  })  : items = items ?? dungeonWorld.equipment,
        super(key: key);

  @override
  _AddInventoryItemState createState() => _AddInventoryItemState();
}

class _AddInventoryItemState extends State<AddInventoryItem> {
  String search = '';

  static String clean(String str, [String replace = '']) =>
      (str ?? '').toLowerCase().replaceAll(RegExp('[^a-z0-9]'), replace);

  @override
  void initState() {
    widget._searchController.addListener(ctrlListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._searchController.removeListener(ctrlListener);
    super.dispose();
  }

  listener([String value]) {
    setState(() {
      search = value ?? widget._searchController.text;
    });
  }

  ctrlListener([String value]) {
    listener(value);
  }

  widgetListener([String value]) {
    listener(value);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Equipment>> itemMap = {};
    Iterable<Equipment> filtered = search.isNotEmpty
        ? widget.items.where((item) => clean(item.name).contains(clean(search)))
        : widget.items;
    filtered.forEach((item) {
      String key =
          item.name.isNotEmpty ? item.name.trim()[0].toUpperCase() : '#';
      itemMap[key] ??= [];
      itemMap[key].add(item);
    });
    if (search != widget._searchController.text) {
      widget._searchController.text = search;
      widget._searchController.selection =
          TextSelection.fromPosition(TextPosition(offset: search.length));
    }
    var searchBar = SearchBar(
      controller: widget._searchController,
      onChanged: widgetListener,
      onSubmitted: widgetListener,
      onEditingComplete: widgetListener,
    );
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 64.0),
          child: CategorizedList.builder(
            items: itemMap.keys.toList()
              ..sort(),
            itemCount: (key, idx) =>
                itemMap[key].length,
            titleBuilder: (ctx, key, idx) =>
                Text(key),
            itemBuilder: (ctx, key, idx, catI) {
              var item = itemMap[key][idx];
              return Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: InventoryItemCard(
                  key: PageStorageKey('add-${item.key}'),
                  item: InventoryItem.fromEquipment(item),
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
              child: searchBar,
            ),
            elevation: 5.0,
          ),
        ),
      ],
    );
  }
}
