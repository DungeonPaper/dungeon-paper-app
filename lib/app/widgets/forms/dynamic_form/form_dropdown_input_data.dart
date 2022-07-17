part of 'form_input_data.dart';

class FormDropdownInputData<T> extends BaseInputData<T> {
  FormDropdownInputData({
    required T value,
    required this.items, //
    this.label,
    //

    this.selectedItemBuilder,
    this.hint,
    this.disabledHint,
    this.onTap,
    this.elevation = 8,
    this.style,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.itemHeight = kMinInteractiveDimension,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.menuMaxHeight,
    this.enableFeedback,
    this.alignment = AlignmentDirectional.centerStart,
    this.borderRadius,
    this.compareTo,
  }) : controller = ValueNotifier(value) {
    init();
  }

  @override
  T get value => controller.value;

  @override
  set value(T value) => controller.value = value;

  final Iterable<DropdownMenuItem<T>> items;
  final Widget? label;
  final bool Function(T, T)? compareTo;

  final Widget? hint;
  final Widget? disabledHint;
  final VoidCallback? onTap;
  final DropdownButtonBuilder? selectedItemBuilder;
  final int elevation;
  final TextStyle? style;
  final Widget? underline;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double? itemHeight;
  final Color? focusColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final Color? dropdownColor;
  final double? menuMaxHeight;
  final bool? enableFeedback;
  final AlignmentGeometry alignment;
  final BorderRadius? borderRadius;

  final ValueNotifier<T> controller;
  late final ValueNotifierStream<T> stream;
  late final StreamSubscription subscription;

  void init() {
    stream = ValueNotifierStream<T>(controller);
  }

  @override
  StreamSubscription<T> listen(void Function(T event)? onData,
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
      hint: hint,
      disabledHint: disabledHint,
      onTap: onTap,
      selectedItemBuilder: selectedItemBuilder,
      elevation: elevation,
      style: style,
      underline: underline ?? Container(),
      icon: icon,
      iconDisabledColor: iconDisabledColor,
      iconEnabledColor: iconEnabledColor,
      iconSize: iconSize,
      isDense: isDense,
      isExpanded: isExpanded,
      itemHeight: itemHeight,
      focusColor: focusColor,
      focusNode: focusNode,
      autofocus: autofocus,
      dropdownColor: dropdownColor,
      menuMaxHeight: menuMaxHeight,
      enableFeedback: enableFeedback,
      alignment: alignment,
      borderRadius: borderRadius ?? rRectShape.borderRadius.resolve(TextDirection.ltr),
    );
  }

  @override
  bool equals(T other) => compareTo != null ? compareTo!(value, other) : value == other;
}
