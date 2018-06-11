import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({Key key}) : super(key: key);

  @override
  _BasicInfoState createState() => new _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: Firestore.instance
            .document('character_bios/B5g6u2M6nPOcPd65XMUr')
            .snapshots(),
        builder: (context, snapshot) {
          return new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  height: MediaQuery.of(context).size.height / 4.0,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter,
                      image: new NetworkImage(
                          'https://i.warosu.org/data/tg/img/0285/75/1385816259432.jpg'),
                    ),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Card(
                        elevation: 2.0,
                        child: new Padding(
                          padding: new EdgeInsets.all(16.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text("Level 1 Immolator"),
                              new Text("Atri",
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]);
        });
  }
}
