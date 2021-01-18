import 'package:dungeon_world_data/tag.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TagConverter implements JsonConverter<Tag, dynamic> {
  const TagConverter();

  @override
  Tag fromJson(dynamic json) {
    if (json == null) {
      return null;
    }

    if (json is Tag) {
      return json;
    }

    if (json is String) {
      return Tag.fromJSON(json);
    }

    throw Exception(
        'Could not determine the constructor for mapping from JSON');
  }

  @override
  dynamic toJson(Tag data) => data;
}
