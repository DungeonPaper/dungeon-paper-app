import 'package:dungeon_world_data/alignment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DWAlignmentConverter
    implements JsonConverter<Alignment, Map<String, dynamic>> {
  const DWAlignmentConverter();

  @override
  Alignment fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Alignment.fromJSON(json);
  }

  @override
  Map<String, dynamic> toJson(Alignment data) => data.toJSON().cast<String, dynamic>();
}
