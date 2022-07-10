part of 'form_input_data.dart';

class FormDiceInputData extends BaseInputData<List<dw.Dice>> {
  FormDiceInputData({
    required List<dw.Dice> value,
    required this.abilityScores,
    required this.guessFrom,
  }) {
    init(value);
  }

  @override
  List<dw.Dice> get value => controller.value;

  @override
  set value(List<dw.Dice> value) => controller.value = value;

  late final ValueNotifier<List<dw.Dice>> controller;
  late final ValueNotifierStream<List<dw.Dice>> stream;
  late final StreamSubscription subscription;
  late List<StreamSubscription> guessListeners;
  late List<ValueNotifier<String>> guessNotifiers;
  late Map<String, String> _resultsCache;

  final AbilityScores abilityScores;
  final Set<String> guessFrom;

  void init(List<dw.Dice> value) {
    controller = ValueNotifier(value);
    stream = ValueNotifierStream<List<dw.Dice>>(controller);
    guessListeners = [];
    guessNotifiers = [];
    _resultsCache = {};
  }

  @override
  void onFormInit() {
    for (final field in guessInputs) {
      debugPrint('adding listener for ${field.name}');
      guessListeners.add(field.data.listen(_listen(field.name)));
      guessNotifiers.add(ValueNotifier(field.data.value));
    }
  }

  Iterable<FormInputData<BaseInputData<dynamic>>> get guessInputs =>
      form.widget.inputs.where((i) => guessFrom.contains(i.name));

  @override
  StreamSubscription<List<dw.Dice>> listen(
    void Function(List<dw.Dice> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      stream
          .asBroadcastStream()
          .listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  @override
  void dispose() {
    stream.dispose();
    for (final listener in guessListeners) {
      listener.cancel();
    }
    guessListeners = [];
  }

  @override
  Widget build(BuildContext context) {
    return DiceListInput(
      controller: controller,
      abilityScores: abilityScores,
      guessFrom: guessNotifiers,
    );
  }

  void Function(dynamic event) _listen(String name) {
    return (data) {
      _resultsCache[name] = data;
      final idx = guessFrom.toList().indexOf(name);
      if (idx >= 0) {
        guessNotifiers[idx].value = data;
      }
    };
  }

  @override
  bool equals(List<dw.Dice> other) =>
      other.length == value.length &&
      enumerate(value).every((dice) => dice.value.toString() == other[dice.index].toString());
}
