import 'package:flutter/foundation.dart';

typedef Listener<T> = void Function(T, Fields);

class Field<T> {
  final String fieldName;
  final T Function(Fields context) _defaultValue;
  T _value;
  bool _dirty = false;
  bool get isDirty => _dirty;
  final Fields context;
  dynamic Function(T value, Fields context) _toJSON;
  T Function(dynamic value, Fields context) _fromJSON;
  final bool isSerialized;
  List<Listener<T>> _listeners;

  Field({
    this.context,
    @required this.fieldName,
    @required T Function(Fields context) defaultValue,
    T value,
    dynamic Function(T value, Fields context) toJSON,
    T Function(dynamic value, Fields context) fromJSON,
    List<Listener<T>> listeners,
    this.isSerialized = true,
  })  : _toJSON = toJSON,
        _fromJSON = fromJSON,
        _defaultValue = defaultValue,
        _listeners = listeners ?? [] {
    this.value = value ?? defaultValue(context);
  }

  T get defaultValue => _defaultValue(context);

  T get value => _value;
  set value(T newVal) {
    var val = newVal ?? defaultValue;
    _value = newVal is T ? val : fromJSON(val, context);
    _dirty = true;
    notifyListeners(newVal);
  }

  T get get => value;
  void set(T val) {
    value = val;
  }

  setDirty(bool value) {
    _dirty = value;
  }

  dynamic toJSON() =>
      isSerialized ? _toJSON != null ? _toJSON(_value, context) : _value : null;

  T fromJSON(dynamic _value, Fields context) => _value is T
      ? _value
      : _fromJSON != null
          ? _fromJSON(_value ?? defaultValue, context)
          : _value ?? defaultValue;

  Field<T> copy(
    Fields newContext, {
    String fieldName,
    T Function(Fields context) defaultValue,
    T value,
    dynamic Function(T value, Fields context) toJSON,
    T Function(dynamic value, Fields context) fromJSON,
    List<Listener<T>> listeners,
    bool isSerialized = true,
  }) =>
      Field<T>(
        fieldName: fieldName ?? this.fieldName,
        defaultValue: defaultValue ?? _defaultValue,
        value: value ?? this.value,
        context: newContext,
        toJSON: toJSON ?? _toJSON,
        fromJSON: fromJSON ?? _fromJSON,
        isSerialized: isSerialized ?? this.isSerialized,
        listeners: listeners ?? _listeners,
      );

  // Listeners
  void addListener(Listener<T> listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  bool removeListener(Listener<T> listener) {
    return _listeners.remove(listener);
  }

  void notifyListeners(T _value) {
    for (var listener in _listeners) {
      listener(_value, context);
    }
  }
}

class Fields<C> {
  Map<String, Field> _map = {};

  Map<String, dynamic> get currentData =>
      _map.map((k, v) => MapEntry(k, v.value));

  Field<T> get<T>(String fieldName) => _map[fieldName];

  register(Iterable<Field> Function(Fields context) fields) {
    for (var field in fields(this)) {
      addField(field);
    }
  }

  addField(Field field) {
    _map[field.fieldName] = field.copy(this);
  }

  Iterable<Field> get fields => _map.values;

  List<String> get dirtyFields => _map.entries
      .where((entry) => entry.value.isDirty == true)
      .map((entry) => entry.key)
      .toList();

  List<String> get cleanFields => _map.entries
      .where((entry) => entry.value.isDirty == false)
      .map((entry) => entry.key)
      .toList();

  Fields<C> copy([dynamic context]) {
    var instance = Fields();
    return instance..register((copy) => _map.values.map((v) => v.copy(copy)));
  }

  addListener<L>(String key, Listener<L> listener) {
    get(key)?.addListener(listener);
  }

  bool removeListener<L>(String key, Listener<L> listener) {
    return get(key)?.removeListener(listener);
  }
}
