class Action<T, A> {
  final A type;
  final T payload;

  Action({this.type, this.payload});
}
