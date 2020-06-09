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
  T _fromJSON(value) {
    try {
      return __fromJSON != null ? __fromJSON(value, context) : value;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  dynamic _toJSON() {
    try {
      return __toJSON != null ? __toJSON(value, context) : value;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

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
        listeners: listeners ?? _listeners,
        defaultValue: defaultValue ?? defaultValueGetter,
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
          fromJSON: (value, ctx) =>
              value == true || value != false && value != null,
        );
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
          fromJSON: (value, ctx) => int.tryParse(value),
        );
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
          defaultValue: defaultValue ?? (ctx) => 0.0,
          value: value,
          listeners: listeners,
          isSerialized: isSerialized,
          fromJSON: (value, ctx) =>
              value is num ? value.toDouble() : double.tryParse(value),
        );
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
          fromJSON: (value, ctx) => value?.toString() ?? '',
        );
}

class ListOfField<V> extends Field<List<V>> {
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
        );

  @override
  FieldBase<List<V>> copy(
    FieldsContext newContext, {
    String fieldName,
    Field<List<V>> field,
    List<V> Function(FieldsContext context) defaultValue,
    List<V> value,
    List<FieldListener<List<V>>> listeners,
    bool isSerialized = true,
  }) =>
      ListOfField<V>(
        context: newContext,
        fieldName: fieldName ?? this.fieldName,
        field: field ?? this.field,
        value: value ?? this.value,
        isSerialized: isSerialized ?? this.isSerialized,
        listeners: listeners ?? _listeners,
        defaultValue: defaultValue ?? defaultValueGetter,
      );
}

class MapOfField<K, V> extends Field<Map<K, V>> {
  final FieldBase field;

  MapOfField({
    @required this.field,
    FieldsContext context,
    @required String fieldName,
    Map<K, V> Function(FieldsContext context) defaultValue,
    Map<K, V> value,
    List<FieldListener<Map<K, V>>> listeners,
    bool isSerialized = true,
  }) : super(
          context: context,
          fieldName: fieldName,
          defaultValue: defaultValue ?? (ctx) => <K, V>{},
          value: value,
          listeners: listeners,
          isSerialized: isSerialized,
          fromJSON: (value, ctx) => value is Map && value.isNotEmpty
              ? value.map<K, V>(
                  (k, v) => MapEntry<K, V>(k, field.copy(ctx).fromJSON(v)))
              : <K, V>{},
          toJSON: (value, ctx) => value is Map && value.isNotEmpty
              ? value.map((k, v) =>
                  MapEntry<K, dynamic>(k, field.copy(ctx, value: v).toJSON()))
              : <K, V>{},
        );

  @override
  FieldBase<Map<K, V>> copy(
    FieldsContext newContext, {
    String fieldName,
    Field<Map<K, V>> field,
    Map<K, V> Function(FieldsContext context) defaultValue,
    Map<K, V> value,
    List<FieldListener<Map<K, V>>> listeners,
    bool isSerialized = true,
  }) =>
      MapOfField<K, V>(
        context: newContext,
        fieldName: fieldName ?? this.fieldName,
        field: field ?? this.field,
        value: value ?? this.value,
        isSerialized: isSerialized ?? this.isSerialized,
        listeners: listeners ?? _listeners,
        defaultValue: defaultValue ?? defaultValueGetter,
      );
}

class StringListField extends ListOfField<String> {
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

class DocumentReferenceListField extends ListOfField<DocumentReference> {
  DocumentReferenceListField({
    FieldsContext context,
    @required String fieldName,
    List<DocumentReference> value,
    List<FieldListener<List<DocumentReference>>> listeners,
    bool isSerialized = true,
    dynamic Function(List<DocumentReference> value, FieldsContext context)
        toJSON,
    List<DocumentReference> Function(dynamic value, FieldsContext context)
        fromJSON,
    List<DocumentReference> Function(FieldsContext context) defaultValue,
  }) : super(
          field: DocumentReferenceField(fieldName: fieldName),
          fieldName: fieldName,
          value: value,
          isSerialized: isSerialized,
          listeners: listeners,
          defaultValue: defaultValue,
        );
}

class DocumentReferenceField extends Field<DocumentReference> {
  DocumentReferenceField({
    FieldsContext context,
    @required String fieldName,
    DocumentReference Function(FieldsContext context) defaultValue,
    DocumentReference value,
    List<FieldListener<DocumentReference>> listeners,
    bool isSerialized = true,
  }) : super(
          context: context,
          fieldName: fieldName,
          defaultValue: defaultValue ?? (ctx) => null,
          value: value,
          listeners: listeners,
          isSerialized: isSerialized,
          fromJSON: (value, ctx) => value,
        );
}
