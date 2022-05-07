import 'package:dungeon_paper/core/localized_repository.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';

import '../list_utils.dart';

typedef NestedStringIterable = Iterable<Iterable<String>>;

abstract class ContentGenerator {
  final repository = LocalizedRepository<NestedStringIterable>();

  ContentGenerator() {
    repository.loadData(mapping);
  }

  abstract final Map<String, Map<String, NestedStringIterable>> mapping;

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
