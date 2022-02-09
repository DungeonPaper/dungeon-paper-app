import 'dart:convert';

class Bio {
  Bio({
    required this.looks,
    required this.description,
  });

  final List<String> looks;
  final String description;

  Bio copyWith({
    List<String>? looks,
    String? description,
  }) =>
      Bio(
        looks: looks ?? this.looks,
        description: description ?? this.description,
      );

  factory Bio.fromRawJson(String str) => Bio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bio.fromJson(Map<String, dynamic> json) => Bio(
        looks: List<String>.from(json["looks"].map((x) => x)),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "looks": List<dynamic>.from(looks.map((x) => x)),
        "description": description,
      };
}
