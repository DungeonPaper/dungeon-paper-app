part of 'form_input_data.dart';

class FormTagsInputData extends BaseInputData {
  FormTagsInputData({
    required this.value,
  }) {
    init();
  }

  @override
  final List<dw.Tag> value;

  late final ValueNotifier<List<dw.Tag>> controller;
  late final ValueNotifierStream<List<dw.Tag>> stream;
  late final StreamSubscription subscription;

  void init() {
    controller = ValueNotifier(value);
    stream = ValueNotifierStream<List<dw.Tag>>(controller);
  }

  @override
  StreamSubscription listen(void Function(dynamic event)? onData,
          {Function? onError, void Function()? onDone, bool? cancelOnError}) =>
      stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  @override
  void dispose() {
    stream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (final tag in value) TagChip(tag: tag),
        TagChip(tag: dw.Tag(name: S.current.createGeneric(dw.Tag), value: null)),
      ],
    );
  }
}
