typedef CallbackDelegate<T, R> = R Function(T obj);
typedef VoidCallbackDelegate<T> = void Function(T obj);
typedef EmptyCallbackDelegate<R> = R Function();
typedef VoidEmptyCallbackDelegate = void Function();
