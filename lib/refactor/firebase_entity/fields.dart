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

  T fromJSON(dynamic _value, Fields context) {
    if (_value is T) {
      return _value;
    }
    if (_fromJSON != null) {
      if (_value != null) {
        if (T is Iterable && _value is Iterable && _value.isNotEmpty) {
          return _fromJSONList(_value, context).toList() as T;
        }
        return _fromJSON(_value, context);
      }
    }
    return defaultValue;
  }

  List<K> _fromJSONList<K, V>(Iterable<V> value, Fields context) =>
      List<K>.from(value);

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
      )..addListeners(_listeners);

  // Listeners
  void addListener(Listener<T> listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void addListeners(Iterable<Listener<T>> listeners) {
    for (var listener in listeners) {
      addListener(listener);
    }
  }

  void removeListeners(Iterable<Listener<T>> listeners) {
    for (var listener in listeners) {
      removeListener(listener);
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

  Fields(Iterable<Field> fields) {
    for (var field in fields) {
      addField(field);
    }
  }

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

  void setDirty(bool state) {
    fields.forEach((field) {
      field.setDirty(state);
    });
  }

  Iterable<Field> get fields => _map.values;
  Iterable<String> get keys => _map.keys;
  Field operator [](String field) => _map[field];
  void operator []=(String field, dynamic value) => _map[field] = value;

  List<String> get dirtyFields => _map.entries
      .where((entry) => entry.value.isDirty == true)
      .map((entry) => entry.key)
      .toList();

  List<String> get cleanFields => _map.entries
      .where((entry) => entry.value.isDirty == false)
      .map((entry) => entry.key)
      .toList();

  Fields<C> copy() {
    return Fields(_map.values);
  }

  Fields<C> copyWith(Iterable<Field> fields) {
    var _copy = copy();
    for (var field in fields) {
      _copy.addField(field);
    }
    return _copy;
  }

  void addListener<L>(Listener<L> listener) {
    for (var key in keys) {
      get(key)?.addListener(listener);
    }
  }

  void removeListener<L>(Listener<L> listener) {
    for (var key in keys) {
      get(key)?.removeListener(listener);
    }
  }
}
