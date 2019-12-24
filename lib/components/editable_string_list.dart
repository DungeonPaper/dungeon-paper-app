import 'package:dungeon_paper/flutter_utils.dart';
import 'package:dungeon_paper/widget_utils.dart';
import 'package:flutter/material.dart';
import '../utils.dart';

class EditableStringList extends StatefulWidget {
  final List<String> strings;
  final VoidCallbackDelegate<List<String>> onSave;
  final String addButtonText;
  final String Function(int idx) placeholderBuilder;
  final ValueNotifier validityNotifier;
  final TextCapitalization textCapitalization;

  EditableStringList({
    Key key,
    this.strings = const [],
    this.onSave,
    this.addButtonText = 'Add New Item',
    String Function(int idx) hintTextBuilder = _emptyPlaceholder,
    String hintText,
    this.validityNotifier,
    this.textCapitalization,
  })  : placeholderBuilder =
            hintText != null ? ((i) => hintText) : hintTextBuilder,
        super(key: key);

  static String _emptyPlaceholder(int i) => '';

  @override
  _EditableStringListState createState() => _EditableStringListState();
}

class _EditableStringListState extends State<EditableStringList> {
  List<TextEditingController> controllers;
  List<String> strings;

  @override
  void initState() {
    super.initState();
    strings = [...widget.strings];
    List<EditingControllerConfig> list = [
      for (Enumeration<String> str in enumerate(strings))
        EditingControllerConfig(
          defaultValue: str.v,
          listener: _updateFor(str.i),
        )
    ];
    controllers = WidgetUtils.textEditingControllerMap(
      list: list,
    ).values.toList();
    if (widget.validityNotifier != null) {
      widget.validityNotifier.value = _isValid();
    }
  }

  VoidEmptyCallbackDelegate _updateFor(int i) {
    return () {
      setState(() {
        strings[i] = controllers[i].text;
      });
      _update();
    };
  }

  void _update() {
    if (widget.validityNotifier != null) {
      widget.validityNotifier.value = _isValid();
    }
    if (widget.onSave != null) widget.onSave(strings);
  }

  void _addRow() {
    setState(() {
      strings.add('');
      controllers.add(EditingControllerConfig(
        defaultValue: '',
        listener: _updateFor(strings.length - 1),
      ).toEditingController());
    });
    _update();
  }

  void _removeAt(int idx) {
    strings.removeAt(idx);
    controllers.removeAt(idx);
    _update();
  }

  bool _isValid() => controllers.every((s) => s.text.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        for (Enumeration<String> str in enumerate(strings))
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: widget.placeholderBuilder(str.index),
                    errorText: str.index == strings.length - 1 &&
                            controllers[str.index].text.isEmpty
                        ? "Can't leave an empty option."
                        : null,
                  ),
                  controller: controllers.length > str.index
                      ? controllers[str.index]
                      : null,
                  textCapitalization: widget.textCapitalization,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed:
                    strings.length > 1 ? () => _removeAt(str.index) : null,
              )
            ],
          ),
        RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text(widget.addButtonText),
          onPressed: strings[strings.length - 1].isNotEmpty ? _addRow : null,
        )
      ],
    );
  }
}
