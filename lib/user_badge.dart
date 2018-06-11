import 'package:flutter/material.dart';

class UserBadge extends StatefulWidget {
  const UserBadge({ Key key }) : super( key: key );

  @override
  _UserBadgeState createState() => new _UserBadgeState();
}

class _UserBadgeState extends State<UserBadge> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      icon: new CircleAvatar(),
      color: _pressed ? Colors.red : Colors.blue,
      onPressed: () => setState(() {
        _pressed = true;
      }),
    );
  }
}
