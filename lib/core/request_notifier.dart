class RequestNotifier<T> {
  final List<T Function()> _listeners = [];
  final T Function() onRequestChanges;

  RequestNotifier(this.onRequestChanges);

  addListener(T Function() listener) {
    _listeners.add(listener);
  }

  removeListener(T Function() listener) {
    _listeners.remove(listener);
  }

  T request() => onRequestChanges();
}
