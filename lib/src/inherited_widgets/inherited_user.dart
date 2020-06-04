import 'package:dungeon_paper/db/models/user.dart';
import 'package:flutter/material.dart';

class InheritedUser extends InheritedWidget {
  final User user;

  InheritedUser({
    Key key,
    @required this.user,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedUser oldWidget) =>
      oldWidget.user != user || oldWidget.user.fields != user.fields;
}
