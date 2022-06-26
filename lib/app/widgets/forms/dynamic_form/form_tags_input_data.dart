part of 'form_input_data.dart';

class FormTagsInputData extends BaseInputData<List<dw.Tag>> {
  FormTagsInputData({
    required List<dw.Tag> value,
  }) {
    init(value);
  }

  @override
  List<dw.Tag> get value => controller.value;

  late final ValueNotifier<List<dw.Tag>> controller;
  late final ValueNotifierStream<List<dw.Tag>> stream;
  late final StreamSubscription subscription;

  void init(List<dw.Tag> value) {
    controller = ValueNotifier(value);
    stream = ValueNotifierStream<List<dw.Tag>>(controller);
  }

  @override
  StreamSubscription<List<dw.Tag>> listen(
    void Function(List<dw.Tag> event)? onData, {
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
  }

  @override
  Widget build(BuildContext context) {
    return TagListInput(controller: controller);
  }
}
