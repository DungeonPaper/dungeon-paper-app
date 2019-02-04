import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/character_types.dart';
import 'package:flutter/material.dart';

class EditStatDialog extends StatefulWidget {
  final String name;
  final num value;
  EditStatDialog({
    Key key,
    @required this.name,
    @required this.value,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      EditStatDialogState(name: name, value: value);
}

class EditStatDialogState extends State<EditStatDialog> {
  final String name;
  final String fullName;
  num value;
  TextEditingController _controller;

  EditStatDialogState({
    Key key,
    @required this.name,
    @required this.value,
  })  : fullName = StatNameMap[name],
        _controller = TextEditingController(text: value.toString()),
        super();

  @override
  Widget build(BuildContext context) {
    String modifier = DbCharacter.statModifierText(value);
    return SimpleDialog(
      title: Text('Edit $fullName'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('$fullName: $value'),
              Text('${name.toUpperCase()}: $modifier',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
              Form(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: 150.0,
                        child: TextField(
                          onChanged: (val) => _setStateValue(num.parse(val) != 0 ? num.parse(val) : ''),
                          keyboardType: TextInputType.number,
                          controller: _controller,
                          // style: TextStyle(fontSize: 13.0),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () => _saveValue(),
                            child: const Text('Save'),
                          ),
                          RaisedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _setStateValue(num newValue) {
    setState(() {
      value = newValue;
    });
  }

  _saveValue() async {
    await updateCharacter({name.toLowerCase(): value});
    Navigator.pop(context);
  }
}
