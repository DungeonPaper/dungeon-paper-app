import 'package:dungeon_paper/db/models/inventory_items.dart';
import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/atoms/search_bar.dart';
import 'package:dungeon_paper/src/molecules/inventory_item_card.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/equipment.dart';
import 'package:flutter/material.dart';

class ExistingInventoryItemsList extends StatelessWidget {
  final Iterable<Equipment> items;
  final void Function(InventoryItem) onSave;

  const ExistingInventoryItemsList({
    Key key,
    this.items,
    @required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AddInventoryItem(
      items: items,
      onSave: onSave,
    );
  }
}

class AddInventoryItem extends StatefulWidget {
  final Iterable<Equipment> items;
  final TextEditingController _searchController = TextEditingController();
  final void Function(InventoryItem) onSave;

  AddInventoryItem({
    Key key,
    Iterable<Equipment> items,
    @required this.onSave,
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
    widget._searchController.addListener(_onChange);
    super.initState();
  }

  @override
  void dispose() {
    widget._searchController.removeListener(_onChange);
    super.dispose();
  }

  void _onChange([String value]) {
    setState(() {
      search = value ?? widget._searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemMap = <String, List<Equipment>>{};
    final filtered = search.isNotEmpty
        ? widget.items.where((item) => clean(item.name).contains(clean(search)))
        : widget.items;
    filtered.forEach((item) {
      final key =
          item.name.isNotEmpty ? item.name.trim()[0].toUpperCase() : '#';
      itemMap[key] ??= [];
      itemMap[key].add(item);
    });
    if (search != widget._searchController.text) {
      widget._searchController.text = search;
      widget._searchController.selection =
          TextSelection.fromPosition(TextPosition(offset: search.length));
    }
    final searchBar = SearchBar(
      hintText: 'Type to search items',
      controller: widget._searchController,
      onChanged: _onChange,
      onSubmitted: _onChange,
      onEditingComplete: _onChange,
    );
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 32),
          child: CategorizedList.builder(
            keyBuilder: null,
            items: itemMap.keys.toList()..sort(),
            itemCount: (key, idx) => itemMap[key].length,
            titleBuilder: (ctx, key, idx) {
              final child = Text(key);
              if (idx == 0) {
                return Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: child,
                );
              }
              return child;
            },
            itemBuilder: (ctx, key, idx, catI) {
              final item = itemMap[key][idx];
              return Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: InventoryItemCard(
                  key: PageStorageKey('add-${item.key}'),
                  item: InventoryItem.fromEquipment(item),
                  mode: InventoryItemCardMode.Addable,
                  onSave: widget.onSave,
                  onDelete: null,
                ),
              );
            },
          ),
        ),
        searchBar
      ],
    );
  }
}
