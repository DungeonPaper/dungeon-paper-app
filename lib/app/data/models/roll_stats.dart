import 'dart:convert';

class RollStats {
  RollStats({
    required this.dex,
    required this.str,
    required this.wis,
    required this.con,
    required this.intl,
    required this.cha,
  });

  final int dex;
  final int str;
  final int wis;
  final int con;
  final int intl;
  final int cha;

  RollStats copyWith({
    int? dex,
    int? str,
    int? wis,
    int? con,
    int? intl,
    int? cha,
  }) =>
      RollStats(
        dex: dex ?? this.dex,
        str: str ?? this.str,
        wis: wis ?? this.wis,
        con: con ?? this.con,
        intl: intl ?? this.intl,
        cha: cha ?? this.cha,
      );

  factory RollStats.fromRawJson(String str) =>
      RollStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RollStats.fromJson(Map<String, dynamic> json) => RollStats(
        dex: json["dex"],
        str: json["str"],
        wis: json["wis"],
        con: json["con"],
        intl: json["int"],
        cha: json["cha"],
      );

  Map<String, dynamic> toJson() => {
        "dex": dex,
        "str": str,
        "wis": wis,
        "con": con,
        "int": intl,
        "cha": cha,
      };

  int get dexMod => modifierForValue(dex);
  int get strMod => modifierForValue(str);
  int get wisMod => modifierForValue(wis);
  int get conMod => modifierForValue(con);
  int get intMod => modifierForValue(intl);
  int get chaMod => modifierForValue(cha);

  static int modifierForValue(int value) {
    var modifiers = {1: -3, 4: -2, 6: -1, 9: 0, 13: 1, 16: 2, 18: 3};

    if (modifiers.containsKey(value)) {
      return modifiers[value]!;
    }

    for (var i = value; i > 0; --i) {
      if (modifiers.containsKey(i)) {
        return modifiers[i]!;
      }
    }

    return -1;
  }
}
