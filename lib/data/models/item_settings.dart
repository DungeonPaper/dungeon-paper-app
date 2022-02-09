import 'dart:convert';

class ItemSettings {
  ItemSettings({
    required this.countArmor,
    required this.countDamage,
    required this.countWeight,
    required this.equipped,
  });

  final bool countArmor;
  final bool countDamage;
  final bool countWeight;
  final bool equipped;

  ItemSettings copyWith({
    bool? countArmor,
    bool? countDamage,
    bool? countWeight,
    bool? equipped,
  }) =>
      ItemSettings(
        countArmor: countArmor ?? this.countArmor,
        countDamage: countDamage ?? this.countDamage,
        countWeight: countWeight ?? this.countWeight,
        equipped: equipped ?? this.equipped,
      );

  factory ItemSettings.fromRawJson(String str) =>
      ItemSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemSettings.fromJson(Map<String, dynamic> json) => ItemSettings(
        countArmor: json["countArmor"],
        countDamage: json["countDamage"],
        countWeight: json["countWeight"],
        equipped: json["equipped"],
      );

  Map<String, dynamic> toJson() => {
        "countArmor": countArmor,
        "countDamage": countDamage,
        "countWeight": countWeight,
        "equipped": equipped,
      };
}
