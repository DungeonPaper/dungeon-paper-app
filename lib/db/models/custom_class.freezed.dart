// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'custom_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
CustomClass _$CustomClassFromJson(Map<String, dynamic> json) {
  return _CustomClass.fromJson(json);
}

/// @nodoc
class _$CustomClassTearOff {
  const _$CustomClassTearOff();

// ignore: unused_element
  _CustomClass call(
      {@DefaultUuid() String key,
      @DocumentReferenceConverter() DocumentReference ref,
      String name,
      String description,
      num load,
      num baseHP,
      @DiceConverter() Dice damage,
      Map<String, List<String>> names,
      List<String> bonds,
      Map<String, List<String>> looks,
      @DWAlignmentConverter() Map<String, Alignment> alignments,
      @DWMoveConverter() List<Move> raceMoves,
      @DWMoveConverter() List<Move> startingMoves,
      @DWMoveConverter() List<Move> advancedMoves1,
      @DWMoveConverter() List<Move> advancedMoves2,
      @DWSpellConverter() List<Spell> spells,
      @DWGearChoiceConverter() List<GearChoice> gearChoices}) {
    return _CustomClass(
      key: key,
      ref: ref,
      name: name,
      description: description,
      load: load,
      baseHP: baseHP,
      damage: damage,
      names: names,
      bonds: bonds,
      looks: looks,
      alignments: alignments,
      raceMoves: raceMoves,
      startingMoves: startingMoves,
      advancedMoves1: advancedMoves1,
      advancedMoves2: advancedMoves2,
      spells: spells,
      gearChoices: gearChoices,
    );
  }

// ignore: unused_element
  CustomClass fromJson(Map<String, Object> json) {
    return CustomClass.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $CustomClass = _$CustomClassTearOff();

/// @nodoc
mixin _$CustomClass {
  @DefaultUuid()
  String get key;
  @DocumentReferenceConverter()
  DocumentReference get ref;
  String get name;
  String get description;
  num get load;
  num get baseHP;
  @DiceConverter()
  Dice get damage;
  Map<String, List<String>> get names;
  List<String> get bonds;
  Map<String, List<String>> get looks;
  @DWAlignmentConverter()
  Map<String, Alignment> get alignments;
  @DWMoveConverter()
  List<Move> get raceMoves;
  @DWMoveConverter()
  List<Move> get startingMoves;
  @DWMoveConverter()
  List<Move> get advancedMoves1;
  @DWMoveConverter()
  List<Move> get advancedMoves2;
  @DWSpellConverter()
  List<Spell> get spells;
  @DWGearChoiceConverter()
  List<GearChoice> get gearChoices;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $CustomClassCopyWith<CustomClass> get copyWith;
}

/// @nodoc
abstract class $CustomClassCopyWith<$Res> {
  factory $CustomClassCopyWith(
          CustomClass value, $Res Function(CustomClass) then) =
      _$CustomClassCopyWithImpl<$Res>;
  $Res call(
      {@DefaultUuid() String key,
      @DocumentReferenceConverter() DocumentReference ref,
      String name,
      String description,
      num load,
      num baseHP,
      @DiceConverter() Dice damage,
      Map<String, List<String>> names,
      List<String> bonds,
      Map<String, List<String>> looks,
      @DWAlignmentConverter() Map<String, Alignment> alignments,
      @DWMoveConverter() List<Move> raceMoves,
      @DWMoveConverter() List<Move> startingMoves,
      @DWMoveConverter() List<Move> advancedMoves1,
      @DWMoveConverter() List<Move> advancedMoves2,
      @DWSpellConverter() List<Spell> spells,
      @DWGearChoiceConverter() List<GearChoice> gearChoices});
}

/// @nodoc
class _$CustomClassCopyWithImpl<$Res> implements $CustomClassCopyWith<$Res> {
  _$CustomClassCopyWithImpl(this._value, this._then);

  final CustomClass _value;
  // ignore: unused_field
  final $Res Function(CustomClass) _then;

  @override
  $Res call({
    Object key = freezed,
    Object ref = freezed,
    Object name = freezed,
    Object description = freezed,
    Object load = freezed,
    Object baseHP = freezed,
    Object damage = freezed,
    Object names = freezed,
    Object bonds = freezed,
    Object looks = freezed,
    Object alignments = freezed,
    Object raceMoves = freezed,
    Object startingMoves = freezed,
    Object advancedMoves1 = freezed,
    Object advancedMoves2 = freezed,
    Object spells = freezed,
    Object gearChoices = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed ? _value.key : key as String,
      ref: ref == freezed ? _value.ref : ref as DocumentReference,
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      load: load == freezed ? _value.load : load as num,
      baseHP: baseHP == freezed ? _value.baseHP : baseHP as num,
      damage: damage == freezed ? _value.damage : damage as Dice,
      names:
          names == freezed ? _value.names : names as Map<String, List<String>>,
      bonds: bonds == freezed ? _value.bonds : bonds as List<String>,
      looks:
          looks == freezed ? _value.looks : looks as Map<String, List<String>>,
      alignments: alignments == freezed
          ? _value.alignments
          : alignments as Map<String, Alignment>,
      raceMoves:
          raceMoves == freezed ? _value.raceMoves : raceMoves as List<Move>,
      startingMoves: startingMoves == freezed
          ? _value.startingMoves
          : startingMoves as List<Move>,
      advancedMoves1: advancedMoves1 == freezed
          ? _value.advancedMoves1
          : advancedMoves1 as List<Move>,
      advancedMoves2: advancedMoves2 == freezed
          ? _value.advancedMoves2
          : advancedMoves2 as List<Move>,
      spells: spells == freezed ? _value.spells : spells as List<Spell>,
      gearChoices: gearChoices == freezed
          ? _value.gearChoices
          : gearChoices as List<GearChoice>,
    ));
  }
}

/// @nodoc
abstract class _$CustomClassCopyWith<$Res>
    implements $CustomClassCopyWith<$Res> {
  factory _$CustomClassCopyWith(
          _CustomClass value, $Res Function(_CustomClass) then) =
      __$CustomClassCopyWithImpl<$Res>;
  @override
  $Res call(
      {@DefaultUuid() String key,
      @DocumentReferenceConverter() DocumentReference ref,
      String name,
      String description,
      num load,
      num baseHP,
      @DiceConverter() Dice damage,
      Map<String, List<String>> names,
      List<String> bonds,
      Map<String, List<String>> looks,
      @DWAlignmentConverter() Map<String, Alignment> alignments,
      @DWMoveConverter() List<Move> raceMoves,
      @DWMoveConverter() List<Move> startingMoves,
      @DWMoveConverter() List<Move> advancedMoves1,
      @DWMoveConverter() List<Move> advancedMoves2,
      @DWSpellConverter() List<Spell> spells,
      @DWGearChoiceConverter() List<GearChoice> gearChoices});
}

/// @nodoc
class __$CustomClassCopyWithImpl<$Res> extends _$CustomClassCopyWithImpl<$Res>
    implements _$CustomClassCopyWith<$Res> {
  __$CustomClassCopyWithImpl(
      _CustomClass _value, $Res Function(_CustomClass) _then)
      : super(_value, (v) => _then(v as _CustomClass));

  @override
  _CustomClass get _value => super._value as _CustomClass;

  @override
  $Res call({
    Object key = freezed,
    Object ref = freezed,
    Object name = freezed,
    Object description = freezed,
    Object load = freezed,
    Object baseHP = freezed,
    Object damage = freezed,
    Object names = freezed,
    Object bonds = freezed,
    Object looks = freezed,
    Object alignments = freezed,
    Object raceMoves = freezed,
    Object startingMoves = freezed,
    Object advancedMoves1 = freezed,
    Object advancedMoves2 = freezed,
    Object spells = freezed,
    Object gearChoices = freezed,
  }) {
    return _then(_CustomClass(
      key: key == freezed ? _value.key : key as String,
      ref: ref == freezed ? _value.ref : ref as DocumentReference,
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      load: load == freezed ? _value.load : load as num,
      baseHP: baseHP == freezed ? _value.baseHP : baseHP as num,
      damage: damage == freezed ? _value.damage : damage as Dice,
      names:
          names == freezed ? _value.names : names as Map<String, List<String>>,
      bonds: bonds == freezed ? _value.bonds : bonds as List<String>,
      looks:
          looks == freezed ? _value.looks : looks as Map<String, List<String>>,
      alignments: alignments == freezed
          ? _value.alignments
          : alignments as Map<String, Alignment>,
      raceMoves:
          raceMoves == freezed ? _value.raceMoves : raceMoves as List<Move>,
      startingMoves: startingMoves == freezed
          ? _value.startingMoves
          : startingMoves as List<Move>,
      advancedMoves1: advancedMoves1 == freezed
          ? _value.advancedMoves1
          : advancedMoves1 as List<Move>,
      advancedMoves2: advancedMoves2 == freezed
          ? _value.advancedMoves2
          : advancedMoves2 as List<Move>,
      spells: spells == freezed ? _value.spells : spells as List<Spell>,
      gearChoices: gearChoices == freezed
          ? _value.gearChoices
          : gearChoices as List<GearChoice>,
    ));
  }
}

@JsonSerializable()
@With(FirebaseMixin)
@With(KeyMixin)

/// @nodoc
class _$_CustomClass extends _CustomClass with FirebaseMixin, KeyMixin {
  const _$_CustomClass(
      {@DefaultUuid() this.key,
      @DocumentReferenceConverter() this.ref,
      this.name,
      this.description,
      this.load,
      this.baseHP,
      @DiceConverter() this.damage,
      this.names,
      this.bonds,
      this.looks,
      @DWAlignmentConverter() this.alignments,
      @DWMoveConverter() this.raceMoves,
      @DWMoveConverter() this.startingMoves,
      @DWMoveConverter() this.advancedMoves1,
      @DWMoveConverter() this.advancedMoves2,
      @DWSpellConverter() this.spells,
      @DWGearChoiceConverter() this.gearChoices})
      : super._();

  factory _$_CustomClass.fromJson(Map<String, dynamic> json) =>
      _$_$_CustomClassFromJson(json);

  @override
  @DefaultUuid()
  final String key;
  @override
  @DocumentReferenceConverter()
  final DocumentReference ref;
  @override
  final String name;
  @override
  final String description;
  @override
  final num load;
  @override
  final num baseHP;
  @override
  @DiceConverter()
  final Dice damage;
  @override
  final Map<String, List<String>> names;
  @override
  final List<String> bonds;
  @override
  final Map<String, List<String>> looks;
  @override
  @DWAlignmentConverter()
  final Map<String, Alignment> alignments;
  @override
  @DWMoveConverter()
  final List<Move> raceMoves;
  @override
  @DWMoveConverter()
  final List<Move> startingMoves;
  @override
  @DWMoveConverter()
  final List<Move> advancedMoves1;
  @override
  @DWMoveConverter()
  final List<Move> advancedMoves2;
  @override
  @DWSpellConverter()
  final List<Spell> spells;
  @override
  @DWGearChoiceConverter()
  final List<GearChoice> gearChoices;

  @override
  String toString() {
    return 'CustomClass(key: $key, ref: $ref, name: $name, description: $description, load: $load, baseHP: $baseHP, damage: $damage, names: $names, bonds: $bonds, looks: $looks, alignments: $alignments, raceMoves: $raceMoves, startingMoves: $startingMoves, advancedMoves1: $advancedMoves1, advancedMoves2: $advancedMoves2, spells: $spells, gearChoices: $gearChoices)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CustomClass &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.ref, ref) ||
                const DeepCollectionEquality().equals(other.ref, ref)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.load, load) ||
                const DeepCollectionEquality().equals(other.load, load)) &&
            (identical(other.baseHP, baseHP) ||
                const DeepCollectionEquality().equals(other.baseHP, baseHP)) &&
            (identical(other.damage, damage) ||
                const DeepCollectionEquality().equals(other.damage, damage)) &&
            (identical(other.names, names) ||
                const DeepCollectionEquality().equals(other.names, names)) &&
            (identical(other.bonds, bonds) ||
                const DeepCollectionEquality().equals(other.bonds, bonds)) &&
            (identical(other.looks, looks) ||
                const DeepCollectionEquality().equals(other.looks, looks)) &&
            (identical(other.alignments, alignments) ||
                const DeepCollectionEquality()
                    .equals(other.alignments, alignments)) &&
            (identical(other.raceMoves, raceMoves) ||
                const DeepCollectionEquality()
                    .equals(other.raceMoves, raceMoves)) &&
            (identical(other.startingMoves, startingMoves) ||
                const DeepCollectionEquality()
                    .equals(other.startingMoves, startingMoves)) &&
            (identical(other.advancedMoves1, advancedMoves1) ||
                const DeepCollectionEquality()
                    .equals(other.advancedMoves1, advancedMoves1)) &&
            (identical(other.advancedMoves2, advancedMoves2) ||
                const DeepCollectionEquality()
                    .equals(other.advancedMoves2, advancedMoves2)) &&
            (identical(other.spells, spells) ||
                const DeepCollectionEquality().equals(other.spells, spells)) &&
            (identical(other.gearChoices, gearChoices) ||
                const DeepCollectionEquality()
                    .equals(other.gearChoices, gearChoices)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(ref) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(load) ^
      const DeepCollectionEquality().hash(baseHP) ^
      const DeepCollectionEquality().hash(damage) ^
      const DeepCollectionEquality().hash(names) ^
      const DeepCollectionEquality().hash(bonds) ^
      const DeepCollectionEquality().hash(looks) ^
      const DeepCollectionEquality().hash(alignments) ^
      const DeepCollectionEquality().hash(raceMoves) ^
      const DeepCollectionEquality().hash(startingMoves) ^
      const DeepCollectionEquality().hash(advancedMoves1) ^
      const DeepCollectionEquality().hash(advancedMoves2) ^
      const DeepCollectionEquality().hash(spells) ^
      const DeepCollectionEquality().hash(gearChoices);

  @JsonKey(ignore: true)
  @override
  _$CustomClassCopyWith<_CustomClass> get copyWith =>
      __$CustomClassCopyWithImpl<_CustomClass>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CustomClassToJson(this);
  }
}

abstract class _CustomClass extends CustomClass
    implements FirebaseMixin, KeyMixin {
  const _CustomClass._() : super._();
  const factory _CustomClass(
      {@DefaultUuid() String key,
      @DocumentReferenceConverter() DocumentReference ref,
      String name,
      String description,
      num load,
      num baseHP,
      @DiceConverter() Dice damage,
      Map<String, List<String>> names,
      List<String> bonds,
      Map<String, List<String>> looks,
      @DWAlignmentConverter() Map<String, Alignment> alignments,
      @DWMoveConverter() List<Move> raceMoves,
      @DWMoveConverter() List<Move> startingMoves,
      @DWMoveConverter() List<Move> advancedMoves1,
      @DWMoveConverter() List<Move> advancedMoves2,
      @DWSpellConverter() List<Spell> spells,
      @DWGearChoiceConverter() List<GearChoice> gearChoices}) = _$_CustomClass;

  factory _CustomClass.fromJson(Map<String, dynamic> json) =
      _$_CustomClass.fromJson;

  @override
  @DefaultUuid()
  String get key;
  @override
  @DocumentReferenceConverter()
  DocumentReference get ref;
  @override
  String get name;
  @override
  String get description;
  @override
  num get load;
  @override
  num get baseHP;
  @override
  @DiceConverter()
  Dice get damage;
  @override
  Map<String, List<String>> get names;
  @override
  List<String> get bonds;
  @override
  Map<String, List<String>> get looks;
  @override
  @DWAlignmentConverter()
  Map<String, Alignment> get alignments;
  @override
  @DWMoveConverter()
  List<Move> get raceMoves;
  @override
  @DWMoveConverter()
  List<Move> get startingMoves;
  @override
  @DWMoveConverter()
  List<Move> get advancedMoves1;
  @override
  @DWMoveConverter()
  List<Move> get advancedMoves2;
  @override
  @DWSpellConverter()
  List<Spell> get spells;
  @override
  @DWGearChoiceConverter()
  List<GearChoice> get gearChoices;
  @override
  @JsonKey(ignore: true)
  _$CustomClassCopyWith<_CustomClass> get copyWith;
}
