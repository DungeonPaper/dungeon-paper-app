import 'dart:convert';

class AlignmentValue {
  AlignmentValue({
    required this.key,
    required this.description,
  });

  final String key;
  final String description;

  AlignmentValue copyWith({
    String? key,
    String? description,
  }) =>
      AlignmentValue(
        key: key ?? this.key,
        description: description ?? this.description,
      );

  factory AlignmentValue.fromRawJson(String str) =>
      AlignmentValue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AlignmentValue.fromJson(Map<String, dynamic> json) => AlignmentValue(
        key: json["key"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "description": description,
      };
}

class AlignmentValues {
  AlignmentValues({
    required this.good,
    required this.evil,
    required this.lawful,
    required this.neutral,
    required this.chaotic,
  });

  final String good;
  final String evil;
  final String lawful;
  final String neutral;
  final String chaotic;

  AlignmentValues copyWith({
    String? good,
    String? evil,
    String? lawful,
    String? neutral,
    String? chaotic,
  }) =>
      AlignmentValues(
        good: good ?? this.good,
        evil: evil ?? this.evil,
        lawful: lawful ?? this.lawful,
        neutral: neutral ?? this.neutral,
        chaotic: chaotic ?? this.chaotic,
      );

  factory AlignmentValues.fromRawJson(String str) =>
      AlignmentValues.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AlignmentValues.fromJson(Map<String, dynamic> json) =>
      AlignmentValues(
        good: json["good"],
        evil: json["evil"],
        lawful: json["lawful"],
        neutral: json["neutral"],
        chaotic: json["chaotic"],
      );

  Map<String, dynamic> toJson() => {
        "good": good,
        "evil": evil,
        "lawful": lawful,
        "neutral": neutral,
        "chaotic": chaotic,
      };
}
