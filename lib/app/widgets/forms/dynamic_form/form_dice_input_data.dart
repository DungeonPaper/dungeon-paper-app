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

  late final ValueNotifier<List<dw.Dice>> controller;
  late final ValueNotifierStream<List<dw.Dice>> stream;
  late final StreamSubscription subscription;
  late List<StreamSubscription> guessListeners;
  late Map<String, String> _resultsCache;
  late Set<dw.Dice> guesses;

  final AbilityScores abilityScores;
  final Set<String> guessFrom;

  void init(List<dw.Dice> value) {
    controller = ValueNotifier(value);
    stream = ValueNotifierStream<List<dw.Dice>>(controller);
    guessListeners = [];
    guesses = {};
    _resultsCache = {};
  }

  @override
  void onFormInit() {
    for (final field in guessInputs) {
      debugPrint('adding listener for ${field.name}');
      guessListeners.add(field.data.listen(_listen(field.name)));
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.current.entityPlural(dw.Dice), style: Theme.of(context).textTheme.caption),
        Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final dice in enumerate(value))
              DiceChip(
                dice: dice.value,
                onPressed: () => Get.dialog(
                  AddDiceDialog(
                    dice: dice.value,
                    abilityScores: abilityScores,
                    onSave: (_dice) {
                      controller.value = updateByIndex(controller.value, _dice, dice.index);
                    },
                  ),
                ),
                onDeleted: () => controller.value = [...controller.value..removeAt(dice.index)],
              ),
            DiceChip(
              dice: dw.Dice.d6,
              label: Text(S.current.addGeneric(dw.Dice)),
              icon: const Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => Get.dialog(
                AddDiceDialog(
                  abilityScores: abilityScores,
                  onSave: (dice) {
                    controller.value = [...controller.value, dice];
                  },
                ),
              ),
            ),
            for (final dice in guesses
                .where((guess) => !value.map((d) => d.toString()).contains(guess.toString())))
              DiceChip(
                dice: dice,
                label: Text(S.current.diceSuggestion(dice.toString())),
                onPressed: () => controller.value = [...controller.value, dice],
              ),
          ],
        ),
      ],
    );
  }

  void _refreshGuess() {
    final guessStr = guessInputs.map((i) => i.data.value).join(' ');
    guesses = dw.Dice.guessFromString(guessStr).toSet();
    controller.value = [...controller.value];
  }

  void Function(dynamic event) _listen(String name) {
    return (data) {
      _resultsCache[name] = data;
      _refreshGuess();
    };
  }
}
