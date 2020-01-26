import 'package:dungeon_paper/components/dialogs.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

import '../../flutter_utils.dart';
import '../../widget_utils.dart';

class ClassBasicDetails extends StatefulWidget {
  final VoidCallbackDelegate<PlayerClass> onUpdate;
  final PlayerClass playerClass;
  final ValueNotifier validityNotifier;
  final DialogMode mode;

  const ClassBasicDetails({
    Key key,
    @required this.playerClass,
    @required this.onUpdate,
    this.validityNotifier,
    @required this.mode,
  }) : super(key: key);

  @override
  _ClassBasicDetailsState createState() => _ClassBasicDetailsState();
}

enum Keys { name, description, baseHP, load }

class _ClassBasicDetailsState extends State<ClassBasicDetails> {
  Map<Keys, TextEditingController> editingControllers;
  @override
  void initState() {
    super.initState();

    editingControllers = WidgetUtils.textEditingControllerMap(
      list: [
        EditingControllerConfig(
          key: Keys.name,
          defaultValue: widget.playerClass.name,
          listener: () {
            PlayerClass def = widget.playerClass;
            def.name = editingControllers[Keys.name].text.trim();
            updateWith(def);
          },
        ),
        EditingControllerConfig(
          key: Keys.description,
          defaultValue: widget.playerClass.description,
          listener: () {
            PlayerClass def = widget.playerClass;
            def.description = editingControllers[Keys.description].text.trim();
            updateWith(def);
          },
        ),
        EditingControllerConfig(
          key: Keys.baseHP,
          defaultValue: (widget.playerClass.baseHP ?? 0).toString(),
          listener: () {
            PlayerClass def = widget.playerClass;
            def.baseHP =
                int.tryParse(editingControllers[Keys.baseHP].text.trim()) ?? 0;
            updateWith(def);
          },
        ),
        EditingControllerConfig(
          key: Keys.load,
          defaultValue: (widget.playerClass.load ?? 0).toString(),
          listener: () {
            PlayerClass def = widget.playerClass;
            def.load =
                int.tryParse(editingControllers[Keys.load].text.trim()) ?? 0;
            updateWith(def);
          },
        ),
      ],
    );

    widget.validityNotifier.value = _isValid();
  }

  updateWith(PlayerClass def) {
    if (widget.validityNotifier != null) {
      widget.validityNotifier.value = _isValid();
    }
    if (widget.onUpdate != null) widget.onUpdate(def);
  }

  bool _isValid() => editingControllers[Keys.name].text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final TextStyle cardCaptionStyle =
        Theme.of(context).textTheme.caption.copyWith(
              color: Theme.of(context).primaryColor,
            );
    final EdgeInsets cardPadding = const EdgeInsets.all(16.0);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              Card(
                child: Padding(
                  padding: cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Name & Information', style: cardCaptionStyle),
                      TextFormField(
                        controller: editingControllers[Keys.name],
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: 'Class name',
                          hintText: 'Barbarian, Paladin, Wizard...',
                          errorText: editingControllers[Keys.name].text.isEmpty ? 'Please enter class name' : null,
                        ),
                      ),
                      TextFormField(
                        controller: editingControllers[Keys.description],
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: null,
                        minLines: 2,
                        decoration: InputDecoration(
                          labelText: 'Class description',
                          hintText:
                              'Describe your class in free-form here.\nBe creative, everyone is watching!',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Stat Basis', style: cardCaptionStyle),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: editingControllers[Keys.baseHP],
                              inputFormatters: [NumberFormatter.int()],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Default Base HP',
                                hintText: '0',
                              ),
                            ),
                          ),
                          Container(width: 24),
                          Expanded(
                            child: TextFormField(
                              controller: editingControllers[Keys.load],
                              inputFormatters: [NumberFormatter.int()],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Default Max Load',
                                hintText: '0',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
