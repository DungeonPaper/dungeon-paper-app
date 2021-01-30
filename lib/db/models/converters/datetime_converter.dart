import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, dynamic> {
  const DateTimeConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    return DateTime.parse(json);
  }

  @override
  dynamic toJson(DateTime data) => data;
}
