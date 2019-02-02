import 'package:dungeon_paper/db/base.dart';

class Note extends DbBase {
  var defaultData = {
    'category': '',
    'title': '',
    'description': '',
  };

  String get category => get('category');
  String get title => get('title');
  String get description => get('description');

  Note([Map map]) : super(map);
}
