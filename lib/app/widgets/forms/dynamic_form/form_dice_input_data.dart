part of 'form_input_data.dart';

class FormDiceInputData extends BaseInputData<List<dw.Dice>> {
  FormDiceInputData({
    required List<dw.Dice> value,
    required this.rollStats,
  }) {
    init(value);
  }

  @override
  List<dw.Dice> get value => controller.value;

  late final ValueNotifier<List<dw.Dice>> controller;
  late final ValueNotifierStream<List<dw.Dice>> stream;
  late final StreamSubscription subscription;

  final RollStats rollStats;

  void init(List<dw.Dice> value) {
    controller = ValueNotifier(value);
    stream = ValueNotifierStream<List<dw.Dice>>(controller);
  }

  @override
  StreamSubscription<List<dw.Dice>> listen(
    void Function(List<dw.Dice> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  @override
  void dispose() {
    stream.dispose();
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
                    rollStats: rollStats,
                    onSave: (_dice) {
                      controller.value = updateByIndex(controller.value, _dice, dice.index);
                    },
                  ),
                ),
                onDeleted: () => controller.value = [...controller.value..removeAt(dice.index)],
              ),
            TagChip(
              tag: dw.Tag(name: S.current.addGeneric(dw.Dice), value: null),
              icon: const Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => Get.dialog(
                AddDiceDialog(
                  rollStats: rollStats,
                  onSave: (dice) {
                    controller.value = [...controller.value, dice];
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
