import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  EditStatDialogState({
    Key key,
    @required this.name,
    @required this.value,
  })  : fullName = DbCharacter.statNameMap[name],
        super();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Title'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 26.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Edit $fullName'),
              Text(value.toString()),
              Form(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextField(
                        onChanged: (val) => _setStateValue(num.parse(val))),
                    RaisedButton(
                      onPressed: () => _saveValue(),
                      child: Text('Submit'),
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
    Firestore firestore = Firestore.instance;
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String charDocId = sharedPrefs.getString('characterId');
    characterStore.dispatch(
      Action(
        type: CharacterActions.SetField,
        payload: {'field': name.toLowerCase(), 'value': value},
      ),
    );
    firestore
        .document('character_bios/$charDocId')
        .updateData({name.toLowerCase(): value});
  }
}
