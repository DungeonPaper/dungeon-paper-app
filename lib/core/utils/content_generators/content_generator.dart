import 'package:dungeon_paper/core/localized_repository.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';

import '../list_utils.dart';

abstract class ContentGenerator {
  final repository = LocalizedRepository<Iterable<Iterable<String>>>();

  ContentGenerator() {
    repository.loadData(mapping);
  }

  abstract final Map<String, Map<String, Iterable<Iterable<String>>>> mapping;

  String Function(String) transformer = toTitleCase;

  String generate() {
    return transformer(
      repository.collections.keys
          .map(
            (key) => repository[key].data.map((seg) => sample(seg)).join(''),
          )
          .join(' '),
    );
  }
}
