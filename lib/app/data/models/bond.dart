import 'dart:convert';

class Bond {
  Bond({
    required this.key,
    required this.description,
    required this.completed,
  });

  final String key;
  final String description;
  final bool completed;

  Bond copyWith({
    String? key,
    String? description,
    bool? completed,
  }) =>
      Bond(
        key: key ?? this.key,
        description: description ?? this.description,
        completed: completed ?? this.completed,
      );

  factory Bond.fromRawJson(String str) => Bond.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bond.fromJson(Map<String, dynamic> json) => Bond(
        key: json["key"],
        completed: json["completed"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "description": description,
        "completed": completed,
      };
}
