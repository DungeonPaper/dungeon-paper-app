// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'character_new.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
CharacterNew _$CharacterNewFromJson(Map<String, dynamic> json) {
  return _CharacterNew.fromJson(json);
}

/// @nodoc
class _$CharacterNewTearOff {
  const _$CharacterNewTearOff();

// ignore: unused_element
  _CharacterNew call(
      {@DocumentReferenceConverter() DocumentReference ref,
      @JsonKey(name: 'armor', defaultValue: 0) int baseArmor,
      @JsonKey(name: 'str', defaultValue: 8) int strength,
      @JsonKey(name: 'dex', defaultValue: 8) int dexterity,
      @JsonKey(name: 'con', defaultValue: 8) int constitution,
      @JsonKey(name: 'wis', defaultValue: 8) int wisdom,
      @JsonKey(name: 'int', defaultValue: 8) int intelligence,
      @JsonKey(name: 'cha', defaultValue: 0) int charisma,
      @PlayerClassConverter() List<PlayerClass> playerClasses,
      AlignmentName alignment,
      int maxHP,
      String displayName = 'Traveler',
      String photoURL,
      int level = 1,
      String bio = '',
      int currentHP,
      int currentXP,
      @DWMoveConverter() List<Move> moves,
      @NoteConverter() List<Note> notes,
      @SpellConverter() List<DbSpell> spells,
      @InventoryItemConverter() List<InventoryItem> inventory,
      @DiceConverter() Dice hitDice,
      List<String> looks,
      @DWMoveConverter() Move race,
      double coins = 0,
      int order,
      @CharacterSettingsConverter() CharacterSettings settings}) {
    return _CharacterNew(
      ref: ref,
      baseArmor: baseArmor,
      strength: strength,
      dexterity: dexterity,
      constitution: constitution,
      wisdom: wisdom,
      intelligence: intelligence,
      charisma: charisma,
      playerClasses: playerClasses,
      alignment: alignment,
      maxHP: maxHP,
      displayName: displayName,
      photoURL: photoURL,
      level: level,
      bio: bio,
      currentHP: currentHP,
      currentXP: currentXP,
      moves: moves,
      notes: notes,
      spells: spells,
      inventory: inventory,
      hitDice: hitDice,
      looks: looks,
      race: race,
      coins: coins,
      order: order,
      settings: settings,
    );
  }

// ignore: unused_element
  CharacterNew fromJson(Map<String, Object> json) {
    return CharacterNew.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $CharacterNew = _$CharacterNewTearOff();

/// @nodoc
mixin _$CharacterNew {
  @DocumentReferenceConverter()
  DocumentReference get ref;
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
  int get maxHP;
  String get displayName;
  String get photoURL;
  int get level;
  String get bio;
  int get currentHP;
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
  Dice get hitDice;
  List<String> get looks;
  @DWMoveConverter()
  Move get race;
  double get coins;
  int get order;
  @CharacterSettingsConverter()
  CharacterSettings get settings;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $CharacterNewCopyWith<CharacterNew> get copyWith;
}

/// @nodoc
abstract class $CharacterNewCopyWith<$Res> {
  factory $CharacterNewCopyWith(
          CharacterNew value, $Res Function(CharacterNew) then) =
      _$CharacterNewCopyWithImpl<$Res>;
  $Res call(
      {@DocumentReferenceConverter() DocumentReference ref,
      @JsonKey(name: 'armor', defaultValue: 0) int baseArmor,
      @JsonKey(name: 'str', defaultValue: 8) int strength,
      @JsonKey(name: 'dex', defaultValue: 8) int dexterity,
      @JsonKey(name: 'con', defaultValue: 8) int constitution,
      @JsonKey(name: 'wis', defaultValue: 8) int wisdom,
      @JsonKey(name: 'int', defaultValue: 8) int intelligence,
      @JsonKey(name: 'cha', defaultValue: 0) int charisma,
      @PlayerClassConverter() List<PlayerClass> playerClasses,
      AlignmentName alignment,
      int maxHP,
      String displayName,
      String photoURL,
      int level,
      String bio,
      int currentHP,
      int currentXP,
      @DWMoveConverter() List<Move> moves,
      @NoteConverter() List<Note> notes,
      @SpellConverter() List<DbSpell> spells,
      @InventoryItemConverter() List<InventoryItem> inventory,
      @DiceConverter() Dice hitDice,
      List<String> looks,
      @DWMoveConverter() Move race,
      double coins,
      int order,
      @CharacterSettingsConverter() CharacterSettings settings});
}

/// @nodoc
class _$CharacterNewCopyWithImpl<$Res> implements $CharacterNewCopyWith<$Res> {
  _$CharacterNewCopyWithImpl(this._value, this._then);

  final CharacterNew _value;
  // ignore: unused_field
  final $Res Function(CharacterNew) _then;

  @override
  $Res call({
    Object ref = freezed,
    Object baseArmor = freezed,
    Object strength = freezed,
    Object dexterity = freezed,
    Object constitution = freezed,
    Object wisdom = freezed,
    Object intelligence = freezed,
    Object charisma = freezed,
    Object playerClasses = freezed,
    Object alignment = freezed,
    Object maxHP = freezed,
    Object displayName = freezed,
    Object photoURL = freezed,
    Object level = freezed,
    Object bio = freezed,
    Object currentHP = freezed,
    Object currentXP = freezed,
    Object moves = freezed,
    Object notes = freezed,
    Object spells = freezed,
    Object inventory = freezed,
    Object hitDice = freezed,
    Object looks = freezed,
    Object race = freezed,
    Object coins = freezed,
    Object order = freezed,
    Object settings = freezed,
  }) {
    return _then(_value.copyWith(
      ref: ref == freezed ? _value.ref : ref as DocumentReference,
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
      maxHP: maxHP == freezed ? _value.maxHP : maxHP as int,
      displayName:
          displayName == freezed ? _value.displayName : displayName as String,
      photoURL: photoURL == freezed ? _value.photoURL : photoURL as String,
      level: level == freezed ? _value.level : level as int,
      bio: bio == freezed ? _value.bio : bio as String,
      currentHP: currentHP == freezed ? _value.currentHP : currentHP as int,
      currentXP: currentXP == freezed ? _value.currentXP : currentXP as int,
      moves: moves == freezed ? _value.moves : moves as List<Move>,
      notes: notes == freezed ? _value.notes : notes as List<Note>,
      spells: spells == freezed ? _value.spells : spells as List<DbSpell>,
      inventory: inventory == freezed
          ? _value.inventory
          : inventory as List<InventoryItem>,
      hitDice: hitDice == freezed ? _value.hitDice : hitDice as Dice,
      looks: looks == freezed ? _value.looks : looks as List<String>,
      race: race == freezed ? _value.race : race as Move,
      coins: coins == freezed ? _value.coins : coins as double,
      order: order == freezed ? _value.order : order as int,
      settings:
          settings == freezed ? _value.settings : settings as CharacterSettings,
    ));
  }
}

/// @nodoc
abstract class _$CharacterNewCopyWith<$Res>
    implements $CharacterNewCopyWith<$Res> {
  factory _$CharacterNewCopyWith(
          _CharacterNew value, $Res Function(_CharacterNew) then) =
      __$CharacterNewCopyWithImpl<$Res>;
  @override
  $Res call(
      {@DocumentReferenceConverter() DocumentReference ref,
      @JsonKey(name: 'armor', defaultValue: 0) int baseArmor,
      @JsonKey(name: 'str', defaultValue: 8) int strength,
      @JsonKey(name: 'dex', defaultValue: 8) int dexterity,
      @JsonKey(name: 'con', defaultValue: 8) int constitution,
      @JsonKey(name: 'wis', defaultValue: 8) int wisdom,
      @JsonKey(name: 'int', defaultValue: 8) int intelligence,
      @JsonKey(name: 'cha', defaultValue: 0) int charisma,
      @PlayerClassConverter() List<PlayerClass> playerClasses,
      AlignmentName alignment,
      int maxHP,
      String displayName,
      String photoURL,
      int level,
      String bio,
      int currentHP,
      int currentXP,
      @DWMoveConverter() List<Move> moves,
      @NoteConverter() List<Note> notes,
      @SpellConverter() List<DbSpell> spells,
      @InventoryItemConverter() List<InventoryItem> inventory,
      @DiceConverter() Dice hitDice,
      List<String> looks,
      @DWMoveConverter() Move race,
      double coins,
      int order,
      @CharacterSettingsConverter() CharacterSettings settings});
}

/// @nodoc
class __$CharacterNewCopyWithImpl<$Res> extends _$CharacterNewCopyWithImpl<$Res>
    implements _$CharacterNewCopyWith<$Res> {
  __$CharacterNewCopyWithImpl(
      _CharacterNew _value, $Res Function(_CharacterNew) _then)
      : super(_value, (v) => _then(v as _CharacterNew));

  @override
  _CharacterNew get _value => super._value as _CharacterNew;

  @override
  $Res call({
    Object ref = freezed,
    Object baseArmor = freezed,
    Object strength = freezed,
    Object dexterity = freezed,
    Object constitution = freezed,
    Object wisdom = freezed,
    Object intelligence = freezed,
    Object charisma = freezed,
    Object playerClasses = freezed,
    Object alignment = freezed,
    Object maxHP = freezed,
    Object displayName = freezed,
    Object photoURL = freezed,
    Object level = freezed,
    Object bio = freezed,
    Object currentHP = freezed,
    Object currentXP = freezed,
    Object moves = freezed,
    Object notes = freezed,
    Object spells = freezed,
    Object inventory = freezed,
    Object hitDice = freezed,
    Object looks = freezed,
    Object race = freezed,
    Object coins = freezed,
    Object order = freezed,
    Object settings = freezed,
  }) {
    return _then(_CharacterNew(
      ref: ref == freezed ? _value.ref : ref as DocumentReference,
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
      maxHP: maxHP == freezed ? _value.maxHP : maxHP as int,
      displayName:
          displayName == freezed ? _value.displayName : displayName as String,
      photoURL: photoURL == freezed ? _value.photoURL : photoURL as String,
      level: level == freezed ? _value.level : level as int,
      bio: bio == freezed ? _value.bio : bio as String,
      currentHP: currentHP == freezed ? _value.currentHP : currentHP as int,
      currentXP: currentXP == freezed ? _value.currentXP : currentXP as int,
      moves: moves == freezed ? _value.moves : moves as List<Move>,
      notes: notes == freezed ? _value.notes : notes as List<Note>,
      spells: spells == freezed ? _value.spells : spells as List<DbSpell>,
      inventory: inventory == freezed
          ? _value.inventory
          : inventory as List<InventoryItem>,
      hitDice: hitDice == freezed ? _value.hitDice : hitDice as Dice,
      looks: looks == freezed ? _value.looks : looks as List<String>,
      race: race == freezed ? _value.race : race as Move,
      coins: coins == freezed ? _value.coins : coins as double,
      order: order == freezed ? _value.order : order as int,
      settings:
          settings == freezed ? _value.settings : settings as CharacterSettings,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_CharacterNew extends _CharacterNew {
  const _$_CharacterNew(
      {@DocumentReferenceConverter() this.ref,
      @JsonKey(name: 'armor', defaultValue: 0) this.baseArmor,
      @JsonKey(name: 'str', defaultValue: 8) this.strength,
      @JsonKey(name: 'dex', defaultValue: 8) this.dexterity,
      @JsonKey(name: 'con', defaultValue: 8) this.constitution,
      @JsonKey(name: 'wis', defaultValue: 8) this.wisdom,
      @JsonKey(name: 'int', defaultValue: 8) this.intelligence,
      @JsonKey(name: 'cha', defaultValue: 0) this.charisma,
      @PlayerClassConverter() this.playerClasses,
      this.alignment,
      this.maxHP,
      this.displayName = 'Traveler',
      this.photoURL,
      this.level = 1,
      this.bio = '',
      this.currentHP,
      this.currentXP,
      @DWMoveConverter() this.moves,
      @NoteConverter() this.notes,
      @SpellConverter() this.spells,
      @InventoryItemConverter() this.inventory,
      @DiceConverter() this.hitDice,
      this.looks,
      @DWMoveConverter() this.race,
      this.coins = 0,
      this.order,
      @CharacterSettingsConverter() this.settings})
      : assert(displayName != null),
        assert(level != null),
        assert(bio != null),
        assert(coins != null),
        super._();

  factory _$_CharacterNew.fromJson(Map<String, dynamic> json) =>
      _$_$_CharacterNewFromJson(json);

  @override
  @DocumentReferenceConverter()
  final DocumentReference ref;
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
  @override
  final AlignmentName alignment;
  @override
  final int maxHP;
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
  final int currentHP;
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
  final Dice hitDice;
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

  @override
  String toString() {
    return 'CharacterNew(ref: $ref, baseArmor: $baseArmor, strength: $strength, dexterity: $dexterity, constitution: $constitution, wisdom: $wisdom, intelligence: $intelligence, charisma: $charisma, playerClasses: $playerClasses, alignment: $alignment, maxHP: $maxHP, displayName: $displayName, photoURL: $photoURL, level: $level, bio: $bio, currentHP: $currentHP, currentXP: $currentXP, moves: $moves, notes: $notes, spells: $spells, inventory: $inventory, hitDice: $hitDice, looks: $looks, race: $race, coins: $coins, order: $order, settings: $settings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CharacterNew &&
            (identical(other.ref, ref) ||
                const DeepCollectionEquality().equals(other.ref, ref)) &&
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
            (identical(other.maxHP, maxHP) ||
                const DeepCollectionEquality().equals(other.maxHP, maxHP)) &&
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
            (identical(other.currentHP, currentHP) ||
                const DeepCollectionEquality()
                    .equals(other.currentHP, currentHP)) &&
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
            (identical(other.hitDice, hitDice) ||
                const DeepCollectionEquality()
                    .equals(other.hitDice, hitDice)) &&
            (identical(other.looks, looks) ||
                const DeepCollectionEquality().equals(other.looks, looks)) &&
            (identical(other.race, race) ||
                const DeepCollectionEquality().equals(other.race, race)) &&
            (identical(other.coins, coins) ||
                const DeepCollectionEquality().equals(other.coins, coins)) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)) &&
            (identical(other.settings, settings) ||
                const DeepCollectionEquality()
                    .equals(other.settings, settings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(ref) ^
      const DeepCollectionEquality().hash(baseArmor) ^
      const DeepCollectionEquality().hash(strength) ^
      const DeepCollectionEquality().hash(dexterity) ^
      const DeepCollectionEquality().hash(constitution) ^
      const DeepCollectionEquality().hash(wisdom) ^
      const DeepCollectionEquality().hash(intelligence) ^
      const DeepCollectionEquality().hash(charisma) ^
      const DeepCollectionEquality().hash(playerClasses) ^
      const DeepCollectionEquality().hash(alignment) ^
      const DeepCollectionEquality().hash(maxHP) ^
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(photoURL) ^
      const DeepCollectionEquality().hash(level) ^
      const DeepCollectionEquality().hash(bio) ^
      const DeepCollectionEquality().hash(currentHP) ^
      const DeepCollectionEquality().hash(currentXP) ^
      const DeepCollectionEquality().hash(moves) ^
      const DeepCollectionEquality().hash(notes) ^
      const DeepCollectionEquality().hash(spells) ^
      const DeepCollectionEquality().hash(inventory) ^
      const DeepCollectionEquality().hash(hitDice) ^
      const DeepCollectionEquality().hash(looks) ^
      const DeepCollectionEquality().hash(race) ^
      const DeepCollectionEquality().hash(coins) ^
      const DeepCollectionEquality().hash(order) ^
      const DeepCollectionEquality().hash(settings);

  @JsonKey(ignore: true)
  @override
  _$CharacterNewCopyWith<_CharacterNew> get copyWith =>
      __$CharacterNewCopyWithImpl<_CharacterNew>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CharacterNewToJson(this);
  }
}

abstract class _CharacterNew extends CharacterNew {
  const _CharacterNew._() : super._();
  const factory _CharacterNew(
          {@DocumentReferenceConverter() DocumentReference ref,
          @JsonKey(name: 'armor', defaultValue: 0) int baseArmor,
          @JsonKey(name: 'str', defaultValue: 8) int strength,
          @JsonKey(name: 'dex', defaultValue: 8) int dexterity,
          @JsonKey(name: 'con', defaultValue: 8) int constitution,
          @JsonKey(name: 'wis', defaultValue: 8) int wisdom,
          @JsonKey(name: 'int', defaultValue: 8) int intelligence,
          @JsonKey(name: 'cha', defaultValue: 0) int charisma,
          @PlayerClassConverter() List<PlayerClass> playerClasses,
          AlignmentName alignment,
          int maxHP,
          String displayName,
          String photoURL,
          int level,
          String bio,
          int currentHP,
          int currentXP,
          @DWMoveConverter() List<Move> moves,
          @NoteConverter() List<Note> notes,
          @SpellConverter() List<DbSpell> spells,
          @InventoryItemConverter() List<InventoryItem> inventory,
          @DiceConverter() Dice hitDice,
          List<String> looks,
          @DWMoveConverter() Move race,
          double coins,
          int order,
          @CharacterSettingsConverter() CharacterSettings settings}) =
      _$_CharacterNew;

  factory _CharacterNew.fromJson(Map<String, dynamic> json) =
      _$_CharacterNew.fromJson;

  @override
  @DocumentReferenceConverter()
  DocumentReference get ref;
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
  int get maxHP;
  @override
  String get displayName;
  @override
  String get photoURL;
  @override
  int get level;
  @override
  String get bio;
  @override
  int get currentHP;
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
  Dice get hitDice;
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
  @JsonKey(ignore: true)
  _$CharacterNewCopyWith<_CharacterNew> get copyWith;
}
