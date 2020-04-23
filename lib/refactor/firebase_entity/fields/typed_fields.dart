part of 'fields.dart';

class Field<T> extends FieldBase<T> {
  final dynamic Function(T value, FieldsContext context) __toJSON;
  final T Function(dynamic value, FieldsContext context) __fromJSON;

  Field({
    FieldsContext context,
    @required String fieldName,
    @required T Function(FieldsContext context) defaultValue,
    T value,
    List<FieldListener<T>> listeners,
    bool isSerialized = true,
    dynamic Function(T value, FieldsContext context) toJSON,
    T Function(dynamic value, FieldsContext context) fromJSON,
  })  : __toJSON = toJSON,
        __fromJSON = fromJSON,
        super(
          context: context,
          fieldName: fieldName,
          defaultValue: defaultValue,
          value: value,
          listeners: listeners,
          isSerialized: isSerialized,
        );

  @override
  T _fromJSON(value) => __fromJSON != null ? __fromJSON(value, context) : value;

  @override
  dynamic _toJSON() => __toJSON != null ? __toJSON(value, context) : value;

  @override
  FieldBase<T> copy(
    FieldsContext newContext, {
    String fieldName,
    T Function(FieldsContext context) defaultValue,
    T value,
    List<FieldListener<T>> listeners,
    bool isSerialized = true,
  }) =>
      Field<T>(
        context: newContext,
        fieldName: fieldName ?? this.fieldName,
        value: value ?? this.value,
        isSerialized: isSerialized ?? this.isSerialized,
        listeners: listeners ?? this._listeners,
        defaultValue: defaultValue ?? this.defaultValueGetter,
        fromJSON: __fromJSON,
        toJSON: __toJSON,
      );
}

class BoolField extends Field<bool> {
  BoolField({
    FieldsContext context,
    @required String fieldName,
    bool Function(FieldsContext context) defaultValue,
    bool value,
    List<FieldListener<bool>> listeners,
    bool isSerialized = true,
  }) : super(
          context: context,
          fieldName: fieldName,
          defaultValue: defaultValue ?? (ctx) => false,
          value: value,
          listeners: listeners,
          isSerialized: isSerialized,
        );

  @override
  bool _fromJSON(value) => value == true || value != false && value != null;
}

class IntField extends Field<int> {
  IntField({
    FieldsContext context,
    @required String fieldName,
    int Function(FieldsContext context) defaultValue,
    int value,
    List<FieldListener<int>> listeners,
    bool isSerialized = true,
  }) : super(
          context: context,
          fieldName: fieldName,
          defaultValue: defaultValue ?? (ctx) => 0,
          value: value,
          listeners: listeners,
          isSerialized: isSerialized,
        );

  @override
  int _fromJSON(value) => int.tryParse(value);
}

class DecimalField extends Field<double> {
  DecimalField({
    FieldsContext context,
    @required String fieldName,
    double Function(FieldsContext context) defaultValue,
    double value,
    List<FieldListener<double>> listeners,
    bool isSerialized = true,
  }) : super(
          context: context,
          fieldName: fieldName,
          defaultValue: defaultValue,
          value: value,
          listeners: listeners,
          isSerialized: isSerialized,
        );

  @override
  double _fromJSON(value) => double.tryParse(value);
}

class StringField extends Field<String> {
  StringField({
    FieldsContext context,
    @required String fieldName,
    String Function(FieldsContext context) defaultValue,
    String value,
    List<FieldListener<String>> listeners,
    bool isSerialized = true,
  }) : super(
          context: context,
          fieldName: fieldName,
          defaultValue: defaultValue ?? (ctx) => '',
          value: value,
          listeners: listeners,
          isSerialized: isSerialized,
        );

  @override
  String _fromJSON(value) => value?.toString();
}

class ListOfField<F extends Field, V> extends Field<List<V>> {
  final FieldBase field;

  ListOfField({
    @required this.field,
    FieldsContext context,
    @required String fieldName,
    List<V> Function(FieldsContext context) defaultValue,
    List<V> value,
    List<FieldListener<List<V>>> listeners,
    bool isSerialized = true,
  }) : super(
          context: context,
          fieldName: fieldName,
          defaultValue: defaultValue ?? (ctx) => [],
          value: value,
          listeners: listeners,
          isSerialized: isSerialized,
          fromJSON: (value, ctx) => value is List && value.isNotEmpty
              ? value.map<V>((el) => field.copy(ctx).fromJSON(el)).toList()
              : [],
          toJSON: (value, ctx) => value is List && value.isNotEmpty
              ? value.map((el) => field.copy(ctx, value: el).toJSON()).toList()
              : [],
          // fromJSON: _fromJSONList<V>(field),
          // toJSON: _toJSONList<V>(field),
        );

  // static List<V> Function(dynamic, FieldsContext) _fromJSONList<V>(
  //         Field field) =>
  //     (value, ctx) => value is List && value.isNotEmpty
  //         ? value.map((el) => field.copy(ctx, value: el).fromJSON(el)).toList()
  //         : [];
  // static List<V> Function(dynamic, FieldsContext) _toJSONList<V>(Field field) =>
  //     (value, ctx) => value is Iterable && value.isNotEmpty
  //         ? value.map((el) => field.copy(ctx, value: el).toJSON()).toList()
  //         : [];

  @override
  FieldBase<List<V>> copy(
    FieldsContext newContext, {
    String fieldName,
    F field,
    List<V> Function(FieldsContext context) defaultValue,
    List<V> value,
    List<FieldListener<List<V>>> listeners,
    bool isSerialized = true,
  }) =>
      ListOfField<F, V>(
        context: newContext,
        fieldName: fieldName ?? this.fieldName,
        field: field ?? this.field,
        value: value ?? this.value,
        isSerialized: isSerialized ?? this.isSerialized,
        listeners: listeners ?? this._listeners,
        defaultValue: defaultValue ?? this.defaultValueGetter,
      );
}

class StringListField extends ListOfField<StringField, String> {
  StringListField({
    FieldsContext context,
    @required String fieldName,
    List<String> value,
    List<FieldListener<List<String>>> listeners,
    bool isSerialized = true,
    dynamic Function(List<String> value, FieldsContext context) toJSON,
    List<String> Function(dynamic value, FieldsContext context) fromJSON,
    List<String> Function(FieldsContext context) defaultValue,
  }) : super(
          field: StringField(fieldName: fieldName),
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue,
        );
}
