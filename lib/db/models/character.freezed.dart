// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'character.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Character _$CharacterFromJson(Map<String, dynamic> json) {
  return _Character.fromJson(json);
}

/// @nodoc
class _$CharacterTearOff {
  const _$CharacterTearOff();

// ignore: unused_element
  _Character call(
      {@DocumentReferenceConverter() DocumentReference ref,
      @DefaultUuid() String key,
      @JsonKey(name: 'armor', defaultValue: 0) int baseArmor,
      @JsonKey(name: 'str', defaultValue: 8) int strength,
      @JsonKey(name: 'dex', defaultValue: 8) int dexterity,
      @JsonKey(name: 'con', defaultValue: 8) int constitution,
      @JsonKey(name: 'wis', defaultValue: 8) int wisdom,
      @JsonKey(name: 'int', defaultValue: 8) int intelligence,
      @JsonKey(name: 'cha', defaultValue: 0) int charisma,
      @PlayerClassConverter() List<PlayerClass> playerClasses,
      AlignmentName alignment = AlignmentName.neutral,
      @JsonKey(name: 'maxHP') int customMaxHP,
      String displayName = 'Traveler',
      String photoURL,
      int level = 1,
      String bio = '',
      @JsonKey(name: 'currentHP', defaultValue: 100) int customCurrentHP,
      int currentXP,
      @DWMoveConverter() List<Move> moves,
      @NoteConverter() List<Note> notes,
      @SpellConverter() List<DbSpell> spells,
      @InventoryItemConverter() List<InventoryItem> inventory,
      @DiceConverter() @JsonKey(name: 'hitDice') Dice customDamageDice,
      List<String> looks,
      @DWMoveConverter() Move race,
      double coins = 0,
      int order,
      @CharacterSettingsConverter() CharacterSettings settings,
      @Deprecated('moved to CharacterSettings') bool useDefaultMaxHP = true}) {
    return _Character(
      ref: ref,
      key: key,
      baseArmor: baseArmor,
      strength: strength,
      dexterity: dexterity,
      constitution: constitution,
      wisdom: wisdom,
      intelligence: intelligence,
      charisma: charisma,
      playerClasses: playerClasses,
      alignment: alignment,
      customMaxHP: customMaxHP,
      displayName: displayName,
      photoURL: photoURL,
      level: level,
      bio: bio,
      customCurrentHP: customCurrentHP,
      currentXP: currentXP,
      moves: moves,
      notes: notes,
      spells: spells,
      inventory: inventory,
      customDamageDice: customDamageDice,
      looks: looks,
      race: race,
      coins: coins,
      order: order,
      settings: settings,
      useDefaultMaxHP: useDefaultMaxHP,
    );
  }

// ignore: unused_element
  Character fromJson(Map<String, Object> json) {
    return Character.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Character = _$CharacterTearOff();

/// @nodoc
mixin _$Character {
  @DocumentReferenceConverter()
  DocumentReference get ref;
  @DefaultUuid()
  String get key;
  @JsonKey(name: 'armor', defaultValue: 0)
  int get baseArmor;
  @JsonKey(name: 'str', defaultValue: 8)
  int get strength;
  @JsonKey(name: 'dex', defaultValue: 8)
  int get dexterity;
  @JsonKey(name: 'con', defaultValue: 8)
  int get constitution;
  @JsonKey(name: 'wis', defaultValue: 8)
  int get wisdom;
  @JsonKey(name: 'int', defaultValue: 8)
  int get intelligence;
  @JsonKey(name: 'cha', defaultValue: 0)
  int get charisma;
  @PlayerClassConverter()
  List<PlayerClass> get playerClasses;
  AlignmentName get alignment;
  @JsonKey(name: 'maxHP')
  int get customMaxHP;
  String get displayName;
  String get photoURL;
  int get level;
  String get bio;
  @JsonKey(name: 'currentHP', defaultValue: 100)
  int get customCurrentHP;
  int get currentXP;
  @DWMoveConverter()
  List<Move> get moves;
  @NoteConverter()
  List<Note> get notes;
  @SpellConverter()
  List<DbSpell> get spells;
  @InventoryItemConverter()
  List<InventoryItem> get inventory;
  @DiceConverter()
  @JsonKey(name: 'hitDice')
  Dice get customDamageDice;
  List<String> get looks;
  @DWMoveConverter()
  Move get race;
  double get coins;
  int get order;
  @CharacterSettingsConverter()
  CharacterSettings get settings;
  @Deprecated('moved to CharacterSettings')
  bool get useDefaultMaxHP;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $CharacterCopyWith<Character> get copyWith;
}

/// @nodoc
abstract class $CharacterCopyWith<$Res> {
  factory $CharacterCopyWith(Character value, $Res Function(Character) then) =
      _$CharacterCopyWithImpl<$Res>;
  $Res call(
      {@DocumentReferenceConverter() DocumentReference ref,
      @DefaultUuid() String key,
      @JsonKey(name: 'armor', defaultValue: 0) int baseArmor,
      @JsonKey(name: 'str', defaultValue: 8) int strength,
      @JsonKey(name: 'dex', defaultValue: 8) int dexterity,
      @JsonKey(name: 'con', defaultValue: 8) int constitution,
      @JsonKey(name: 'wis', defaultValue: 8) int wisdom,
      @JsonKey(name: 'int', defaultValue: 8) int intelligence,
      @JsonKey(name: 'cha', defaultValue: 0) int charisma,
      @PlayerClassConverter() List<PlayerClass> playerClasses,
      AlignmentName alignment,
      @JsonKey(name: 'maxHP') int customMaxHP,
      String displayName,
      String photoURL,
      int level,
      String bio,
      @JsonKey(name: 'currentHP', defaultValue: 100) int customCurrentHP,
      int currentXP,
      @DWMoveConverter() List<Move> moves,
      @NoteConverter() List<Note> notes,
      @SpellConverter() List<DbSpell> spells,
      @InventoryItemConverter() List<InventoryItem> inventory,
      @DiceConverter() @JsonKey(name: 'hitDice') Dice customDamageDice,
      List<String> looks,
      @DWMoveConverter() Move race,
      double coins,
      int order,
      @CharacterSettingsConverter() CharacterSettings settings,
      @Deprecated('moved to CharacterSettings') bool useDefaultMaxHP});

  $CharacterSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class _$CharacterCopyWithImpl<$Res> implements $CharacterCopyWith<$Res> {
  _$CharacterCopyWithImpl(this._value, this._then);

  final Character _value;
  // ignore: unused_field
  final $Res Function(Character) _then;

  @override
  $Res call({
    Object ref = freezed,
    Object key = freezed,
    Object baseArmor = freezed,
    Object strength = freezed,
    Object dexterity = freezed,
    Object constitution = freezed,
    Object wisdom = freezed,
    Object intelligence = freezed,
    Object charisma = freezed,
    Object playerClasses = freezed,
    Object alignment = freezed,
    Object customMaxHP = freezed,
    Object displayName = freezed,
    Object photoURL = freezed,
    Object level = freezed,
    Object bio = freezed,
    Object customCurrentHP = freezed,
    Object currentXP = freezed,
    Object moves = freezed,
    Object notes = freezed,
    Object spells = freezed,
    Object inventory = freezed,
    Object customDamageDice = freezed,
    Object looks = freezed,
    Object race = freezed,
    Object coins = freezed,
    Object order = freezed,
    Object settings = freezed,
    Object useDefaultMaxHP = freezed,
  }) {
    return _then(_value.copyWith(
      ref: ref == freezed ? _value.ref : ref as DocumentReference,
      key: key == freezed ? _value.key : key as String,
      baseArmor: baseArmor == freezed ? _value.baseArmor : baseArmor as int,
      strength: strength == freezed ? _value.strength : strength as int,
      dexterity: dexterity == freezed ? _value.dexterity : dexterity as int,
      constitution:
          constitution == freezed ? _value.constitution : constitution as int,
      wisdom: wisdom == freezed ? _value.wisdom : wisdom as int,
      intelligence:
          intelligence == freezed ? _value.intelligence : intelligence as int,
      charisma: charisma == freezed ? _value.charisma : charisma as int,
      playerClasses: playerClasses == freezed
          ? _value.playerClasses
          : playerClasses as List<PlayerClass>,
      alignment:
          alignment == freezed ? _value.alignment : alignment as AlignmentName,
      customMaxHP:
          customMaxHP == freezed ? _value.customMaxHP : customMaxHP as int,
      displayName:
          displayName == freezed ? _value.displayName : displayName as String,
      photoURL: photoURL == freezed ? _value.photoURL : photoURL as String,
      level: level == freezed ? _value.level : level as int,
      bio: bio == freezed ? _value.bio : bio as String,
      customCurrentHP: customCurrentHP == freezed
          ? _value.customCurrentHP
          : customCurrentHP as int,
      currentXP: currentXP == freezed ? _value.currentXP : currentXP as int,
      moves: moves == freezed ? _value.moves : moves as List<Move>,
      notes: notes == freezed ? _value.notes : notes as List<Note>,
      spells: spells == freezed ? _value.spells : spells as List<DbSpell>,
      inventory: inventory == freezed
          ? _value.inventory
          : inventory as List<InventoryItem>,
      customDamageDice: customDamageDice == freezed
          ? _value.customDamageDice
          : customDamageDice as Dice,
      looks: looks == freezed ? _value.looks : looks as List<String>,
      race: race == freezed ? _value.race : race as Move,
      coins: coins == freezed ? _value.coins : coins as double,
      order: order == freezed ? _value.order : order as int,
      settings:
          settings == freezed ? _value.settings : settings as CharacterSettings,
      useDefaultMaxHP: useDefaultMaxHP == freezed
          ? _value.useDefaultMaxHP
          : useDefaultMaxHP as bool,
    ));
  }

  @override
  $CharacterSettingsCopyWith<$Res> get settings {
    if (_value.settings == null) {
      return null;
    }
    return $CharacterSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value));
    });
  }
}

/// @nodoc
abstract class _$CharacterCopyWith<$Res> implements $CharacterCopyWith<$Res> {
  factory _$CharacterCopyWith(
          _Character value, $Res Function(_Character) then) =
      __$CharacterCopyWithImpl<$Res>;
  @override
  $Res call(
      {@DocumentReferenceConverter() DocumentReference ref,
      @DefaultUuid() String key,
      @JsonKey(name: 'armor', defaultValue: 0) int baseArmor,
      @JsonKey(name: 'str', defaultValue: 8) int strength,
      @JsonKey(name: 'dex', defaultValue: 8) int dexterity,
      @JsonKey(name: 'con', defaultValue: 8) int constitution,
      @JsonKey(name: 'wis', defaultValue: 8) int wisdom,
      @JsonKey(name: 'int', defaultValue: 8) int intelligence,
      @JsonKey(name: 'cha', defaultValue: 0) int charisma,
      @PlayerClassConverter() List<PlayerClass> playerClasses,
      AlignmentName alignment,
      @JsonKey(name: 'maxHP') int customMaxHP,
      String displayName,
      String photoURL,
      int level,
      String bio,
      @JsonKey(name: 'currentHP', defaultValue: 100) int customCurrentHP,
      int currentXP,
      @DWMoveConverter() List<Move> moves,
      @NoteConverter() List<Note> notes,
      @SpellConverter() List<DbSpell> spells,
      @InventoryItemConverter() List<InventoryItem> inventory,
      @DiceConverter() @JsonKey(name: 'hitDice') Dice customDamageDice,
      List<String> looks,
      @DWMoveConverter() Move race,
      double coins,
      int order,
      @CharacterSettingsConverter() CharacterSettings settings,
      @Deprecated('moved to CharacterSettings') bool useDefaultMaxHP});

  @override
  $CharacterSettingsCopyWith<$Res> get settings;
}

/// @nodoc
class __$CharacterCopyWithImpl<$Res> extends _$CharacterCopyWithImpl<$Res>
    implements _$CharacterCopyWith<$Res> {
  __$CharacterCopyWithImpl(_Character _value, $Res Function(_Character) _then)
      : super(_value, (v) => _then(v as _Character));

  @override
  _Character get _value => super._value as _Character;

  @override
  $Res call({
    Object ref = freezed,
    Object key = freezed,
    Object baseArmor = freezed,
    Object strength = freezed,
    Object dexterity = freezed,
    Object constitution = freezed,
    Object wisdom = freezed,
    Object intelligence = freezed,
    Object charisma = freezed,
    Object playerClasses = freezed,
    Object alignment = freezed,
    Object customMaxHP = freezed,
    Object displayName = freezed,
    Object photoURL = freezed,
    Object level = freezed,
    Object bio = freezed,
    Object customCurrentHP = freezed,
    Object currentXP = freezed,
    Object moves = freezed,
    Object notes = freezed,
    Object spells = freezed,
    Object inventory = freezed,
    Object customDamageDice = freezed,
    Object looks = freezed,
    Object race = freezed,
    Object coins = freezed,
    Object order = freezed,
    Object settings = freezed,
    Object useDefaultMaxHP = freezed,
  }) {
    return _then(_Character(
      ref: ref == freezed ? _value.ref : ref as DocumentReference,
      key: key == freezed ? _value.key : key as String,
      baseArmor: baseArmor == freezed ? _value.baseArmor : baseArmor as int,
      strength: strength == freezed ? _value.strength : strength as int,
      dexterity: dexterity == freezed ? _value.dexterity : dexterity as int,
      constitution:
          constitution == freezed ? _value.constitution : constitution as int,
      wisdom: wisdom == freezed ? _value.wisdom : wisdom as int,
      intelligence:
          intelligence == freezed ? _value.intelligence : intelligence as int,
      charisma: charisma == freezed ? _value.charisma : charisma as int,
      playerClasses: playerClasses == freezed
          ? _value.playerClasses
          : playerClasses as List<PlayerClass>,
      alignment:
          alignment == freezed ? _value.alignment : alignment as AlignmentName,
      customMaxHP:
          customMaxHP == freezed ? _value.customMaxHP : customMaxHP as int,
      displayName:
          displayName == freezed ? _value.displayName : displayName as String,
      photoURL: photoURL == freezed ? _value.photoURL : photoURL as String,
      level: level == freezed ? _value.level : level as int,
      bio: bio == freezed ? _value.bio : bio as String,
      customCurrentHP: customCurrentHP == freezed
          ? _value.customCurrentHP
          : customCurrentHP as int,
      currentXP: currentXP == freezed ? _value.currentXP : currentXP as int,
      moves: moves == freezed ? _value.moves : moves as List<Move>,
      notes: notes == freezed ? _value.notes : notes as List<Note>,
      spells: spells == freezed ? _value.spells : spells as List<DbSpell>,
      inventory: inventory == freezed
          ? _value.inventory
          : inventory as List<InventoryItem>,
      customDamageDice: customDamageDice == freezed
          ? _value.customDamageDice
          : customDamageDice as Dice,
      looks: looks == freezed ? _value.looks : looks as List<String>,
      race: race == freezed ? _value.race : race as Move,
      coins: coins == freezed ? _value.coins : coins as double,
      order: order == freezed ? _value.order : order as int,
      settings:
          settings == freezed ? _value.settings : settings as CharacterSettings,
      useDefaultMaxHP: useDefaultMaxHP == freezed
          ? _value.useDefaultMaxHP
          : useDefaultMaxHP as bool,
    ));
  }
}

@JsonSerializable()
@With(FirebaseMixin)
@With(KeyMixin)

/// @nodoc
class _$_Character extends _Character with FirebaseMixin, KeyMixin {
  const _$_Character(
      {@DocumentReferenceConverter() this.ref,
      @DefaultUuid() this.key,
      @JsonKey(name: 'armor', defaultValue: 0) this.baseArmor,
      @JsonKey(name: 'str', defaultValue: 8) this.strength,
      @JsonKey(name: 'dex', defaultValue: 8) this.dexterity,
      @JsonKey(name: 'con', defaultValue: 8) this.constitution,
      @JsonKey(name: 'wis', defaultValue: 8) this.wisdom,
      @JsonKey(name: 'int', defaultValue: 8) this.intelligence,
      @JsonKey(name: 'cha', defaultValue: 0) this.charisma,
      @PlayerClassConverter() this.playerClasses,
      this.alignment = AlignmentName.neutral,
      @JsonKey(name: 'maxHP') this.customMaxHP,
      this.displayName = 'Traveler',
      this.photoURL,
      this.level = 1,
      this.bio = '',
      @JsonKey(name: 'currentHP', defaultValue: 100) this.customCurrentHP,
      this.currentXP,
      @DWMoveConverter() this.moves,
      @NoteConverter() this.notes,
      @SpellConverter() this.spells,
      @InventoryItemConverter() this.inventory,
      @DiceConverter() @JsonKey(name: 'hitDice') this.customDamageDice,
      this.looks,
      @DWMoveConverter() this.race,
      this.coins = 0,
      this.order,
      @CharacterSettingsConverter() this.settings,
      @Deprecated('moved to CharacterSettings') this.useDefaultMaxHP = true})
      : assert(alignment != null),
        assert(displayName != null),
        assert(level != null),
        assert(bio != null),
        assert(coins != null),
        assert(useDefaultMaxHP != null),
        super._();

  factory _$_Character.fromJson(Map<String, dynamic> json) =>
      _$_$_CharacterFromJson(json);

  @override
  @DocumentReferenceConverter()
  final DocumentReference ref;
  @override
  @DefaultUuid()
  final String key;
  @override
  @JsonKey(name: 'armor', defaultValue: 0)
  final int baseArmor;
  @override
  @JsonKey(name: 'str', defaultValue: 8)
  final int strength;
  @override
  @JsonKey(name: 'dex', defaultValue: 8)
  final int dexterity;
  @override
  @JsonKey(name: 'con', defaultValue: 8)
  final int constitution;
  @override
  @JsonKey(name: 'wis', defaultValue: 8)
  final int wisdom;
  @override
  @JsonKey(name: 'int', defaultValue: 8)
  final int intelligence;
  @override
  @JsonKey(name: 'cha', defaultValue: 0)
  final int charisma;
  @override
  @PlayerClassConverter()
  final List<PlayerClass> playerClasses;
  @JsonKey(defaultValue: AlignmentName.neutral)
  @override
  final AlignmentName alignment;
  @override
  @JsonKey(name: 'maxHP')
  final int customMaxHP;
  @JsonKey(defaultValue: 'Traveler')
  @override
  final String displayName;
  @override
  final String photoURL;
  @JsonKey(defaultValue: 1)
  @override
  final int level;
  @JsonKey(defaultValue: '')
  @override
  final String bio;
  @override
  @JsonKey(name: 'currentHP', defaultValue: 100)
  final int customCurrentHP;
  @override
  final int currentXP;
  @override
  @DWMoveConverter()
  final List<Move> moves;
  @override
  @NoteConverter()
  final List<Note> notes;
  @override
  @SpellConverter()
  final List<DbSpell> spells;
  @override
  @InventoryItemConverter()
  final List<InventoryItem> inventory;
  @override
  @DiceConverter()
  @JsonKey(name: 'hitDice')
  final Dice customDamageDice;
  @override
  final List<String> looks;
  @override
  @DWMoveConverter()
  final Move race;
  @JsonKey(defaultValue: 0)
  @override
  final double coins;
  @override
  final int order;
  @override
  @CharacterSettingsConverter()
  final CharacterSettings settings;
  @JsonKey(defaultValue: true)
  @override
  @Deprecated('moved to CharacterSettings')
  final bool useDefaultMaxHP;

  @override
  String toString() {
    return 'Character(ref: $ref, key: $key, baseArmor: $baseArmor, strength: $strength, dexterity: $dexterity, constitution: $constitution, wisdom: $wisdom, intelligence: $intelligence, charisma: $charisma, playerClasses: $playerClasses, alignment: $alignment, customMaxHP: $customMaxHP, displayName: $displayName, photoURL: $photoURL, level: $level, bio: $bio, customCurrentHP: $customCurrentHP, currentXP: $currentXP, moves: $moves, notes: $notes, spells: $spells, inventory: $inventory, customDamageDice: $customDamageDice, looks: $looks, race: $race, coins: $coins, order: $order, settings: $settings, useDefaultMaxHP: $useDefaultMaxHP)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Character &&
            (identical(other.ref, ref) ||
                const DeepCollectionEquality().equals(other.ref, ref)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.baseArmor, baseArmor) ||
                const DeepCollectionEquality()
                    .equals(other.baseArmor, baseArmor)) &&
            (identical(other.strength, strength) ||
                const DeepCollectionEquality()
                    .equals(other.strength, strength)) &&
            (identical(other.dexterity, dexterity) ||
                const DeepCollectionEquality()
                    .equals(other.dexterity, dexterity)) &&
            (identical(other.constitution, constitution) ||
                const DeepCollectionEquality()
                    .equals(other.constitution, constitution)) &&
            (identical(other.wisdom, wisdom) ||
                const DeepCollectionEquality().equals(other.wisdom, wisdom)) &&
            (identical(other.intelligence, intelligence) ||
                const DeepCollectionEquality()
                    .equals(other.intelligence, intelligence)) &&
            (identical(other.charisma, charisma) ||
                const DeepCollectionEquality()
                    .equals(other.charisma, charisma)) &&
            (identical(other.playerClasses, playerClasses) ||
                const DeepCollectionEquality()
                    .equals(other.playerClasses, playerClasses)) &&
            (identical(other.alignment, alignment) ||
                const DeepCollectionEquality()
                    .equals(other.alignment, alignment)) &&
            (identical(other.customMaxHP, customMaxHP) ||
                const DeepCollectionEquality()
                    .equals(other.customMaxHP, customMaxHP)) &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)) &&
            (identical(other.photoURL, photoURL) ||
                const DeepCollectionEquality()
                    .equals(other.photoURL, photoURL)) &&
            (identical(other.level, level) ||
                const DeepCollectionEquality().equals(other.level, level)) &&
            (identical(other.bio, bio) ||
                const DeepCollectionEquality().equals(other.bio, bio)) &&
            (identical(other.customCurrentHP, customCurrentHP) ||
                const DeepCollectionEquality()
                    .equals(other.customCurrentHP, customCurrentHP)) &&
            (identical(other.currentXP, currentXP) ||
                const DeepCollectionEquality()
                    .equals(other.currentXP, currentXP)) &&
            (identical(other.moves, moves) ||
                const DeepCollectionEquality().equals(other.moves, moves)) &&
            (identical(other.notes, notes) ||
                const DeepCollectionEquality().equals(other.notes, notes)) &&
            (identical(other.spells, spells) ||
                const DeepCollectionEquality().equals(other.spells, spells)) &&
            (identical(other.inventory, inventory) ||
                const DeepCollectionEquality()
                    .equals(other.inventory, inventory)) &&
            (identical(other.customDamageDice, customDamageDice) ||
                const DeepCollectionEquality()
                    .equals(other.customDamageDice, customDamageDice)) &&
            (identical(other.looks, looks) ||
                const DeepCollectionEquality().equals(other.looks, looks)) &&
            (identical(other.race, race) ||
                const DeepCollectionEquality().equals(other.race, race)) &&
            (identical(other.coins, coins) ||
                const DeepCollectionEquality().equals(other.coins, coins)) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)) &&
            (identical(other.settings, settings) ||
                const DeepCollectionEquality().equals(other.settings, settings)) &&
            (identical(other.useDefaultMaxHP, useDefaultMaxHP) || const DeepCollectionEquality().equals(other.useDefaultMaxHP, useDefaultMaxHP)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(ref) ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(baseArmor) ^
      const DeepCollectionEquality().hash(strength) ^
      const DeepCollectionEquality().hash(dexterity) ^
      const DeepCollectionEquality().hash(constitution) ^
      const DeepCollectionEquality().hash(wisdom) ^
      const DeepCollectionEquality().hash(intelligence) ^
      const DeepCollectionEquality().hash(charisma) ^
      const DeepCollectionEquality().hash(playerClasses) ^
      const DeepCollectionEquality().hash(alignment) ^
      const DeepCollectionEquality().hash(customMaxHP) ^
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(photoURL) ^
      const DeepCollectionEquality().hash(level) ^
      const DeepCollectionEquality().hash(bio) ^
      const DeepCollectionEquality().hash(customCurrentHP) ^
      const DeepCollectionEquality().hash(currentXP) ^
      const DeepCollectionEquality().hash(moves) ^
      const DeepCollectionEquality().hash(notes) ^
      const DeepCollectionEquality().hash(spells) ^
      const DeepCollectionEquality().hash(inventory) ^
      const DeepCollectionEquality().hash(customDamageDice) ^
      const DeepCollectionEquality().hash(looks) ^
      const DeepCollectionEquality().hash(race) ^
      const DeepCollectionEquality().hash(coins) ^
      const DeepCollectionEquality().hash(order) ^
      const DeepCollectionEquality().hash(settings) ^
      const DeepCollectionEquality().hash(useDefaultMaxHP);

  @JsonKey(ignore: true)
  @override
  _$CharacterCopyWith<_Character> get copyWith =>
      __$CharacterCopyWithImpl<_Character>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CharacterToJson(this);
  }
}

abstract class _Character extends Character implements FirebaseMixin, KeyMixin {
  const _Character._() : super._();
  const factory _Character(
          {@DocumentReferenceConverter() DocumentReference ref,
          @DefaultUuid() String key,
          @JsonKey(name: 'armor', defaultValue: 0) int baseArmor,
          @JsonKey(name: 'str', defaultValue: 8) int strength,
          @JsonKey(name: 'dex', defaultValue: 8) int dexterity,
          @JsonKey(name: 'con', defaultValue: 8) int constitution,
          @JsonKey(name: 'wis', defaultValue: 8) int wisdom,
          @JsonKey(name: 'int', defaultValue: 8) int intelligence,
          @JsonKey(name: 'cha', defaultValue: 0) int charisma,
          @PlayerClassConverter() List<PlayerClass> playerClasses,
          AlignmentName alignment,
          @JsonKey(name: 'maxHP') int customMaxHP,
          String displayName,
          String photoURL,
          int level,
          String bio,
          @JsonKey(name: 'currentHP', defaultValue: 100) int customCurrentHP,
          int currentXP,
          @DWMoveConverter() List<Move> moves,
          @NoteConverter() List<Note> notes,
          @SpellConverter() List<DbSpell> spells,
          @InventoryItemConverter() List<InventoryItem> inventory,
          @DiceConverter() @JsonKey(name: 'hitDice') Dice customDamageDice,
          List<String> looks,
          @DWMoveConverter() Move race,
          double coins,
          int order,
          @CharacterSettingsConverter() CharacterSettings settings,
          @Deprecated('moved to CharacterSettings') bool useDefaultMaxHP}) =
      _$_Character;

  factory _Character.fromJson(Map<String, dynamic> json) =
      _$_Character.fromJson;

  @override
  @DocumentReferenceConverter()
  DocumentReference get ref;
  @override
  @DefaultUuid()
  String get key;
  @override
  @JsonKey(name: 'armor', defaultValue: 0)
  int get baseArmor;
  @override
  @JsonKey(name: 'str', defaultValue: 8)
  int get strength;
  @override
  @JsonKey(name: 'dex', defaultValue: 8)
  int get dexterity;
  @override
  @JsonKey(name: 'con', defaultValue: 8)
  int get constitution;
  @override
  @JsonKey(name: 'wis', defaultValue: 8)
  int get wisdom;
  @override
  @JsonKey(name: 'int', defaultValue: 8)
  int get intelligence;
  @override
  @JsonKey(name: 'cha', defaultValue: 0)
  int get charisma;
  @override
  @PlayerClassConverter()
  List<PlayerClass> get playerClasses;
  @override
  AlignmentName get alignment;
  @override
  @JsonKey(name: 'maxHP')
  int get customMaxHP;
  @override
  String get displayName;
  @override
  String get photoURL;
  @override
  int get level;
  @override
  String get bio;
  @override
  @JsonKey(name: 'currentHP', defaultValue: 100)
  int get customCurrentHP;
  @override
  int get currentXP;
  @override
  @DWMoveConverter()
  List<Move> get moves;
  @override
  @NoteConverter()
  List<Note> get notes;
  @override
  @SpellConverter()
  List<DbSpell> get spells;
  @override
  @InventoryItemConverter()
  List<InventoryItem> get inventory;
  @override
  @DiceConverter()
  @JsonKey(name: 'hitDice')
  Dice get customDamageDice;
  @override
  List<String> get looks;
  @override
  @DWMoveConverter()
  Move get race;
  @override
  double get coins;
  @override
  int get order;
  @override
  @CharacterSettingsConverter()
  CharacterSettings get settings;
  @override
  @Deprecated('moved to CharacterSettings')
  bool get useDefaultMaxHP;
  @override
  @JsonKey(ignore: true)
  _$CharacterCopyWith<_Character> get copyWith;
}
