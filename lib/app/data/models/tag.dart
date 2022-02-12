import 'dart:convert';

class Tag {
  Tag({
    required this.name,
    required this.value,
  });

  final String name;
  final int value;

  Tag copyWith({
    String? name,
    int? value,
  }) =>
      Tag(
        name: name ?? this.name,
        value: value ?? this.value,
      );

  factory Tag.fromRawJson(String str) => Tag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
