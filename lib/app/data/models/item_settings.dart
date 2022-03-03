import 'dart:convert';

class ItemSettings {
  ItemSettings({
    this.countArmor = true,
    this.countDamage = true,
    this.countWeight = true,
  });

  final bool countArmor;
  final bool countDamage;
  final bool countWeight;

  ItemSettings copyWith({
    bool? countArmor,
    bool? countDamage,
    bool? countWeight,
  }) =>
      ItemSettings(
        countArmor: countArmor ?? this.countArmor,
        countDamage: countDamage ?? this.countDamage,
        countWeight: countWeight ?? this.countWeight,
      );

  factory ItemSettings.fromRawJson(String str) => ItemSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemSettings.fromJson(Map<String, dynamic> json) => ItemSettings(
        countArmor: json['countArmor'],
        countDamage: json['countDamage'],
        countWeight: json['countWeight'],
      );

  Map<String, dynamic> toJson() => {
        'countArmor': countArmor,
        'countDamage': countDamage,
        'countWeight': countWeight,
      };
}
