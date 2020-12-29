import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectableList<T> extends StatefulWidget {
  final Iterable<T> selected;
  final Iterable<T> list;
  final void Function(Set<T>) onChange;
  final Widget Function(T item, int index, bool isSelected,
      void Function(bool) onToggle, BuildContext context) itemBuilder;
  final Widget Function(
          bool allSelected, void Function(bool) onToggle, BuildContext context)
      selectAllBuilder;
  final Widget leading;
  final Widget trailing;
  final TextStyle titleStyle;

  const SelectableList({
    Key key,
    @required this.selected,
    @required this.list,
    @required this.onChange,
    @required this.itemBuilder,
    @required this.selectAllBuilder,
    this.leading,
    this.trailing,
    this.titleStyle,
  }) : super(key: key);

  @override
  _SelectableListState createState() => _SelectableListState<T>();

  factory SelectableList.checkboxTile({
    @required Iterable<T> selected,
    @required Iterable<T> list,
    @required void Function(Set<T>) onChange,
    @required
        Widget Function(T item, int index, BuildContext context) titleBuilder,
    Widget Function(bool allSelected, void Function(bool) onToggle,
            BuildContext context)
        selectAllBuilder,
    Widget leading,
    Widget trailing,
    TextStyle selectAllTextStyle,
  }) =>
      SelectableList<T>(
        selected: selected,
        list: list,
        onChange: onChange,
        itemBuilder: (T item, idx, isSelected, onToggle, context) =>
            CheckboxListTile(
          value: isSelected,
          title: titleBuilder(item, idx, context),
          onChanged: onToggle,
        ),
        selectAllBuilder: (value, onToggle, context) => CheckboxListTile(
          value: value,
          title: DefaultTextStyle(
            child: Text('Select All'),
            style: TextStyle(
              color: Get.theme.colorScheme.onSurface.withOpacity(0.6),
            ).merge(selectAllTextStyle),
          ),
          onChanged: onToggle,
        ),
        leading: leading,
        trailing: trailing,
      );
}

class _SelectableListState<T> extends State<SelectableList<T>> {
  Set<T> selected;
  Iterable<T> get list => widget.list;

  @override
  void initState() {
    super.initState();
    selected = Set.from(widget.selected ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.selectAllBuilder(
          _allChecked(list),
          _onCheckAll(list),
          context,
        ),
        Divider(),
        for (var item in enumerate(list))
          widget.itemBuilder(
            item.value,
            item.index,
            _isChecked(item.value, list),
            _onChecked(item.value),
            context,
          ),
      ],
    );
  }

  void Function(bool) _onChecked(T item) {
    return (bool state) {
      setState(() {
        if (state) {
          selected.add(item);
        } else {
          selected.remove(item);
        }
        widget.onChange?.call(selected);
      });
    };
  }

  void Function(bool) _onCheckAll(Iterable<T> list) {
    return (bool state) {
      setState(() {
        if (state) {
          selected = list.toSet();
        } else {
          selected = {};
        }
        widget.onChange?.call(selected);
      });
    };
  }

  bool _isChecked(T item, Iterable<T> list) => selected.contains(item);

  bool _allChecked(Iterable<T> list) =>
      list.every((item) => selected.contains(item));
}
