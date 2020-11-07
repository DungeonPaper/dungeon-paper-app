part of 'fields.dart';

abstract class FieldBase<T> {
  final String fieldName;
  String get outputFieldName => _outputFieldName ?? fieldName;
  final String _outputFieldName;
  final T Function(FieldsContext context) defaultValueGetter;
  T _value;
  bool _dirty = false;
  bool get isDirty => _dirty;
  final FieldsContext context;
  dynamic _toJSON() => value;
  T _fromJSON(dynamic value);
  final bool isSerialized;
  final List<FieldListener<T>> _listeners;

  FieldBase({
    @required this.context,
    @required this.fieldName,
    String outputFieldName,
    @required T Function(FieldsContext context) defaultValue,
    @required T value,
    @required List<FieldListener<T>> listeners,
    @required this.isSerialized,
  })  : defaultValueGetter = defaultValue,
        _outputFieldName = outputFieldName,
        _listeners = listeners ?? [] {
    this.value = value ?? defaultValue(context);
  }

  T get defaultValue => defaultValueGetter(context);

  T get value => _value;
  set value(T newVal) {
    var val = newVal ?? defaultValue;
    _value = newVal is T ? val : fromJSON(val);
    _dirty = true;
    notifyListeners(newVal);
  }

  T get get => value;
  void set(T val) {
    value = val;
  }

  void setDirty(bool value) {
    _dirty = value;
  }

  dynamic toJSON() => isSerialized
      ? _toJSON != null
          ? _toJSON()
          : _value
      : null;

  T fromJSON(dynamic _value) {
    if (_value is T) {
      return _value;
    }
    if (_fromJSON != null && _value != null) {
      return _fromJSON(_value);
    }
    return defaultValue;
  }

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
      );

  // Listeners
  void addListener(FieldListener<T> listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  void addListeners(Iterable<FieldListener<T>> listeners) {
    for (var listener in listeners) {
      addListener(listener);
    }
  }

  void removeListeners(Iterable<FieldListener<T>> listeners) {
    for (var listener in listeners) {
      removeListener(listener);
    }
  }

  bool removeListener(FieldListener<T> listener) {
    return _listeners.remove(listener);
  }

  void notifyListeners([T _value]) {
    for (var listener in _listeners) {
      listener(_value ?? value, context);
    }
  }
}
