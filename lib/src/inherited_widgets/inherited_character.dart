import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:flutter/widgets.dart';

class InheritedCharacter extends InheritedWidget {
  final Character character;

  InheritedCharacter({
    Key key,
    @required this.character,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedCharacter oldWidget) =>
      oldWidget.character != character ||
      oldWidget.character.fields != character.fields;
}

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
