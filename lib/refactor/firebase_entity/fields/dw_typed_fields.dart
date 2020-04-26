part of 'fields.dart';

abstract class DWEntityField<T extends DWEntity> extends Field<T> {
  final T Function(Map) create;

  DWEntityField({
    FieldsContext context,
    @required String fieldName,
    @required this.create,
    T value,
    List<FieldListener<T>> listeners,
    bool isSerialized = true,
    T Function(FieldsContext ctx) defaultValue,
    dynamic Function(T value, FieldsContext ctx) toJSON,
  }) : super(
          context: context,
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue,
          fromJSON: (value, ctx) => value is T ? value : create(value),
          toJSON: (value, ctx) => value is T
              ? toJSON != null ? toJSON(value, ctx) : value.toJSON()
              : value,
        );
}

class DWEntityListField<T extends DWEntity> extends ListOfField<T> {
  DWEntityListField({
    FieldsContext context,
    @required DWEntityField<T> field,
    @required String fieldName,
    List<T> value,
    List<FieldListener<List<T>>> listeners,
    bool isSerialized = true,
    List<T> Function(FieldsContext context) defaultValue,
  }) : super(
          field: field,
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue,
        );
}

class MoveField extends DWEntityField<Move> {
  MoveField({
    FieldsContext context,
    @required String fieldName,
    Move value,
    List<FieldListener<Move>> listeners,
    bool isSerialized = true,
    Move Function(FieldsContext ctx) defaultValue,
  }) : super(
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue ??
              (ctx) => Move(
                    name: '',
                    description: '',
                    explanation: '',
                    classes: [],
                  ),
          create: (value) => Move.fromJSON(value),
        );
}

class MoveListField extends DWEntityListField<Move> {
  MoveListField({
    FieldsContext context,
    @required String fieldName,
    List<Move> value,
    List<FieldListener<List<Move>>> listeners,
    bool isSerialized = true,
    dynamic Function(List<Move> value, FieldsContext context) toJSON,
    List<Move> Function(dynamic value, FieldsContext context) fromJSON,
    List<Move> Function(FieldsContext context) defaultValue,
  }) : super(
          field: MoveField(
            context: context,
            fieldName: fieldName,
            isSerialized: isSerialized,
          ),
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue,
        );
}

class DiceField extends Field<Dice> {
  DiceField({
    FieldsContext context,
    @required String fieldName,
    Dice value,
    List<FieldListener<Dice>> listeners,
    bool isSerialized = true,
    Dice Function(FieldsContext ctx) defaultValue,
  }) : super(
          context: context,
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue ?? (ctx) => Dice.d6,
          fromJSON: (value, ctx) => Dice.parse(value),
          toJSON: (value, ctx) => value.toString(),
        );
}

class InventoryItemField extends DWEntityField<InventoryItem> {
  InventoryItemField({
    FieldsContext context,
    @required String fieldName,
    InventoryItem value,
    List<FieldListener<InventoryItem>> listeners,
    bool isSerialized = true,
    InventoryItem Function(FieldsContext ctx) defaultValue,
  }) : super(
          context: context,
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          create: (value) => InventoryItem.fromJSON(value),
          defaultValue: defaultValue ??
              (ctx) => InventoryItem(
                    name: '',
                    description: '',
                    amount: 1,
                    tags: [],
                  ),
        );
}

class InventoryItemListField extends ListOfField<InventoryItem> {
  InventoryItemListField({
    FieldsContext context,
    @required String fieldName,
    List<InventoryItem> value,
    List<FieldListener<List<InventoryItem>>> listeners,
    bool isSerialized = true,
    dynamic Function(List<InventoryItem> value, FieldsContext context) toJSON,
    List<InventoryItem> Function(dynamic value, FieldsContext context) fromJSON,
    List<InventoryItem> Function(FieldsContext context) defaultValue,
  }) : super(
          field: InventoryItemField(fieldName: fieldName),
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue,
        );
}

class SpellField extends DWEntityField<DbSpell> {
  SpellField({
    FieldsContext context,
    @required String fieldName,
    DbSpell value,
    List<FieldListener<DbSpell>> listeners,
    bool isSerialized = true,
    DbSpell Function(FieldsContext ctx) defaultValue,
  }) : super(
          context: context,
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue ??
              (ctx) => DbSpell(
                    name: '',
                    description: '',
                    level: 'Cantrip',
                    prepared: false,
                    tags: [],
                  ),
          create: (value) => DbSpell.fromJSON(value),
        );
}

class SpellListField extends ListOfField<DbSpell> {
  SpellListField({
    FieldsContext context,
    @required String fieldName,
    List<DbSpell> value,
    List<FieldListener<List<DbSpell>>> listeners,
    bool isSerialized = true,
    dynamic Function(List<DbSpell> value, FieldsContext context) toJSON,
    List<DbSpell> Function(dynamic value, FieldsContext context) fromJSON,
    List<DbSpell> Function(FieldsContext context) defaultValue,
  }) : super(
          field: SpellField(fieldName: fieldName),
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue,
        );
}

class NoteField extends Field<Note> {
  NoteField({
    FieldsContext context,
    @required String fieldName,
    Note value,
    List<FieldListener<Note>> listeners,
    bool isSerialized = true,
    Note Function(FieldsContext ctx) defaultValue,
  }) : super(
          context: context,
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue ?? (ctx) => Note(),
          fromJSON: (value, ctx) => Note.fromJSON(value),
          toJSON: (value, ctx) => value.toJSON(),
        );
}

class NoteListField extends ListOfField<Note> {
  NoteListField({
    FieldsContext context,
    @required String fieldName,
    List<Note> value,
    List<FieldListener<List<Note>>> listeners,
    bool isSerialized = true,
    dynamic Function(List<Note> value, FieldsContext context) toJSON,
    List<Note> Function(dynamic value, FieldsContext context) fromJSON,
    List<Note> Function(FieldsContext context) defaultValue,
  }) : super(
          field: NoteField(fieldName: fieldName),
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue,
        );
}

class PlayerClassField extends DWEntityField<PlayerClass> {
  PlayerClassField({
    FieldsContext context,
    @required String fieldName,
    PlayerClass value,
    List<FieldListener<PlayerClass>> listeners,
    bool isSerialized = true,
    PlayerClass Function(FieldsContext ctx) defaultValue,
  }) : super(
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue ??
              (ctx) => PlayerClass(
                    name: '',
                    description: '',
                    baseHP: 0,
                    load: 0,
                    damage: Dice.d6,
                    looks: [
                      ['']
                    ],
                    startingMoves: [],
                    advancedMoves1: [],
                    advancedMoves2: [],
                    alignments: {},
                    names: {},
                    bonds: [],
                    gearChoices: [],
                    raceMoves: [],
                    spells: [],
                  ),
          create: (value) => PlayerClass.fromJSON(_fbJsonToDwJson(value)),
          toJSON: (value, ctx) => _dwJsonToFbJson(value.toJSON()),
        );

  static _fbJsonToDwJson(Map json) => json['looks'] is List
      ? json
      : {
          ...json,
          'looks': (json['looks'] as Map).values.toList(),
        };
  static _dwJsonToFbJson(Map json) => json['looks'] is Map
      ? json
      : {
          ...json,
          'looks': (json['looks'] as List<List<String>>)
              .asMap()
              .map((k, v) => MapEntry<String, List<String>>(k.toString(), v)),
        };
}

class PlayerClassListField extends DWEntityListField<PlayerClass> {
  PlayerClassListField({
    FieldsContext context,
    @required String fieldName,
    List<PlayerClass> value,
    List<FieldListener<List<PlayerClass>>> listeners,
    bool isSerialized = true,
    List<PlayerClass> Function(FieldsContext context) defaultValue,
  }) : super(
          field: PlayerClassField(
            context: context,
            fieldName: fieldName,
            isSerialized: isSerialized,
          ),
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue,
        );
}

class AlignmentNameField extends Field<AlignmentName> {
  AlignmentNameField({
    FieldsContext context,
    @required String fieldName,
    AlignmentName value,
    List<FieldListener<AlignmentName>> listeners,
    bool isSerialized = true,
    AlignmentName Function(FieldsContext ctx) defaultValue,
  }) : super(
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue ?? (ctx) => AlignmentName.neutral,
          fromJSON: (alignment, ctx) => AlignmentMap.entries
              .firstWhere((entry) => entry.value == alignment)
              .key,
          toJSON: (alignment, ctx) => enumName(alignment),
        );
}

class AlignmentField extends DWEntityField<Alignment> {
  AlignmentField({
    FieldsContext context,
    @required String fieldName,
    Alignment value,
    List<FieldListener<Alignment>> listeners,
    bool isSerialized = true,
    Alignment Function(FieldsContext ctx) defaultValue,
  }) : super(
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue ??
              (ctx) => Alignment(
                    name: '',
                    description: '',
                  ),
          create: (value) => Alignment.fromJSON(value),
        );
}

class AlignmentListField extends DWEntityListField<Alignment> {
  AlignmentListField({
    FieldsContext context,
    @required String fieldName,
    List<Alignment> value,
    List<FieldListener<List<Alignment>>> listeners,
    bool isSerialized = true,
    dynamic Function(List<Alignment> value, FieldsContext context) toJSON,
    List<Alignment> Function(dynamic value, FieldsContext context) fromJSON,
    List<Alignment> Function(FieldsContext context) defaultValue,
  }) : super(
          field: AlignmentField(
            context: context,
            fieldName: fieldName,
            isSerialized: isSerialized,
          ),
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue,
        );
}

class CharacterField extends Field<Character> {
  CharacterField({
    FieldsContext context,
    @required String fieldName,
    Character value,
    List<FieldListener<Character>> listeners,
    bool isSerialized = true,
    Character Function(FieldsContext ctx) defaultValue,
  }) : super(
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue ?? (ctx) => Character(),
          fromJSON: (value, ctx) => value is Map &&
                  (value.containsKey('data') || value.containsKey('docIS'))
              ? Character(
                  ref: firestore.document(value['docID']),
                  data: value['data'],
                )
              : Character(data: value),
          toJSON: (value, ctx) => value.toJSON(),
        );
}

class CharacterListField extends ListOfField<Character> {
  CharacterListField({
    FieldsContext context,
    @required String fieldName,
    List<Character> value,
    List<FieldListener<List<Character>>> listeners,
    bool isSerialized = true,
    List<Character> Function(FieldsContext context) defaultValue,
  }) : super(
          field: CharacterField(
            context: context,
            fieldName: fieldName,
            isSerialized: isSerialized,
          ),
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue,
        );
}

class NamesMapField extends MapOfField<String, List<String>> {
  NamesMapField({
    FieldsContext context,
    @required String fieldName,
    Map<String, List<String>> value,
    List<FieldListener<Map<String, List<String>>>> listeners,
    bool isSerialized = true,
    Map<String, List<String>> Function(FieldsContext ctx) defaultValue,
  }) : super(
          context: context,
          field: StringListField(fieldName: fieldName),
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
        );
}

class BondsListField extends StringListField {
  BondsListField({
    FieldsContext context,
    @required String fieldName,
    List<String> value,
    List<FieldListener<List<String>>> listeners,
    bool isSerialized = true,
    List<String> Function(FieldsContext ctx) defaultValue,
  }) : super(
          context: context,
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
        );
}

class LooksOptionsListField extends ListOfField<List<String>> {
  LooksOptionsListField({
    FieldsContext context,
    @required String fieldName,
    List<List<String>> value,
    List<FieldListener<List<List<String>>>> listeners,
    bool isSerialized = true,
    List<List<String>> Function(FieldsContext ctx) defaultValue,
  }) : super(
          context: context,
          fieldName: fieldName,
          field: StringListField(fieldName: fieldName),
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
        );
}

class AlignmentsMapField extends MapOfField<String, AlignmentName> {
  AlignmentsMapField({
    FieldsContext context,
    @required String fieldName,
    Map<String, AlignmentName> value,
    List<FieldListener<Map<String, AlignmentName>>> listeners,
    bool isSerialized = true,
    Map<String, AlignmentName> Function(FieldsContext ctx) defaultValue,
  }) : super(
          context: context,
          field: ListOfField<String>(
            fieldName: fieldName,
            field: StringField(fieldName: fieldName),
          ),
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue ?? (ctx) => <String, AlignmentName>{},
        );
}

class GearChoiceField extends DWEntityField<GearChoice> {
  GearChoiceField({
    FieldsContext context,
    @required String fieldName,
    GearChoice value,
    List<FieldListener<GearChoice>> listeners,
    bool isSerialized = true,
    GearChoice Function(FieldsContext ctx) defaultValue,
  }) : super(
          context: context,
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          create: (value) => GearChoice.fromJSON(value),
        );
}

class GearChoiceListField extends DWEntityListField<GearChoice> {
  GearChoiceListField({
    FieldsContext context,
    @required String fieldName,
    List<GearChoice> value,
    List<FieldListener<List<GearChoice>>> listeners,
    bool isSerialized = true,
    List<GearChoice> Function(FieldsContext ctx) defaultValue,
  }) : super(
          context: context,
          fieldName: fieldName,
          field: GearChoiceField(fieldName: fieldName),
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
        );
}
