import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/atoms/editable_string_list.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/utils/types.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CustomClassLooks extends StatefulWidget {
  final Map<String, List<String>> looks;
  final VoidCallbackDelegate<List<List<String>>> onUpdate;
  final ValueNotifier validityNotifier;
  final DialogMode mode;

  const CustomClassLooks({
    Key key,
    this.looks = const {},
    this.onUpdate,
    this.validityNotifier,
    @required this.mode,
  }) : super(key: key);

  @override
  _CustomClassLooksState createState() => _CustomClassLooksState();
}

class _CustomClassLooksState extends State<CustomClassLooks> {
  List<List<String>> items;
  List<Key> keys;
  List<ValueNotifier> validities;

  static const ADD = '+';
  static const double BUTTON_SIZE = 50;

  @override
  void initState() {
    items = List<List<String>>.from(widget.looks.values);
    keys = List.generate(items.length, (i) => Key(Uuid().v4()));
    validities = List.generate(
        items.length,
        (i) => ValueNotifier<bool>(items[i].every((s) => s.isNotEmpty))
          ..addListener(_listener));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CategorizedList.builder(
      keyBuilder: null,
      items: [...items, ADD],
      itemCount: (cat, i) => 1,
      itemBuilder: _childBuilder,
    );
  }

  Widget _childBuilder(BuildContext context, list, num i, num catI) {
    if (list is String && list == ADD) {
      return Center(
        child: AddButton(
          size: BUTTON_SIZE,
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          onPressed: _isValid() ? _addRow : null,
          textScaleFactor: 1.5,
        ),
      );
    }

    var idx = items.indexOf(list);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text('Choice Set #${idx + 1}',
                      style: Theme.of(context).textTheme.headline6),
                ),
                IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.delete_forever),
                  onPressed: () => _removeKey(keys[idx]),
                )
              ],
            ),
            EditableStringList(
              key: keys[idx],
              strings: list,
              addButtonText: 'Add Choice',
              hintText: 'Type an option',
              validityNotifier: validities[idx],
              textCapitalization: TextCapitalization.words,
              onSave: (lst) {
                setState(() {
                  if (items.length <= i) {
                    items.add(lst);
                  } else {
                    items[idx] = lst;
                  }
                });
                _update();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addRow() {
    setState(() {
      items.add(['']);
      keys.add(Key(Uuid().v4()));
      validities.add(ValueNotifier(false)..addListener(_listener));
    });

    _update();
  }

  void _removeKey(Key key) {
    setState(() {
      var idx = keys.indexOf(key);
      keys.removeAt(idx);
      items.removeAt(idx);
      validities.removeAt(idx);
    });
    _update();
  }

  void _listener() {
    widget.validityNotifier?.value = _isValid();
  }

  void _update() {
    widget.validityNotifier?.value = _isValid();
    if (widget.onUpdate != null) widget.onUpdate(items);
  }

  bool _isValid() => validities.every((v) => v.value);
}
