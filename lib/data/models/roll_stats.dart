import 'dart:convert';

class RollStats {
  RollStats({
    required this.dex,
    required this.str,
    required this.wis,
    required this.con,
    required this.rollStatsInt,
    required this.cha,
  });

  final int dex;
  final int str;
  final int wis;
  final int con;
  final int rollStatsInt;
  final int cha;

  RollStats copyWith({
    int? dex,
    int? str,
    int? wis,
    int? con,
    int? rollStatsInt,
    int? cha,
  }) =>
      RollStats(
        dex: dex ?? this.dex,
        str: str ?? this.str,
        wis: wis ?? this.wis,
        con: con ?? this.con,
        rollStatsInt: rollStatsInt ?? this.rollStatsInt,
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
        rollStatsInt: json["int"],
        cha: json["cha"],
      );

  Map<String, dynamic> toJson() => {
        "dex": dex,
        "str": str,
        "wis": wis,
        "con": con,
        "int": rollStatsInt,
        "cha": cha,
      };
}
