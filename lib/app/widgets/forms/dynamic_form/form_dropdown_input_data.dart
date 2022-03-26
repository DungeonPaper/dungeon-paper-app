part of 'form_input_data.dart';

class FormDropdownInputData<T> extends BaseInputData {
  FormDropdownInputData({
    required this.value,
    required this.items,
    this.label,
  }) {
    init();
  }

  @override
  final T value;

  final Iterable<DropdownMenuItem<T>> items;
  final Widget? label;

  late final ValueNotifier<T> controller;
  late final ValueNotifierStream<T> stream;
  late final StreamSubscription subscription;

  void init() {
    controller = ValueNotifier(value);
    stream = ValueNotifierStream<T>(controller);
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
    return SelectBox<dynamic>(
      label: label,
      value: controller.value,
      items: items.toList(),
      onChanged: (value) => controller.value = value, // data.onChange,
    );
  }
}
