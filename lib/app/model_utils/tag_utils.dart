import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class TagUtils {
  static List<dw.Tag> excludeMetaTags(Iterable<dw.Tag> tags) =>
      tags.where((tag) => !['language', 'source'].contains(tag.name.toLowerCase().trim())).toList();
}
