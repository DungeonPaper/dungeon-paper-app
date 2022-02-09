import 'dart:convert';

class Bond {
  Bond({
    required this.key,
    required this.description,
  });

  final String key;
  final String description;

  Bond copyWith({
    String? key,
    String? description,
  }) =>
      Bond(
        key: key ?? this.key,
        description: description ?? this.description,
      );

  factory Bond.fromRawJson(String str) => Bond.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bond.fromJson(Map<String, dynamic> json) => Bond(
        key: json["key"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "description": description,
      };
}
