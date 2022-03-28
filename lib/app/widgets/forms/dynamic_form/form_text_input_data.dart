part of 'form_input_data.dart';

class FormTextInputData extends BaseInputData<String> {
  FormTextInputData({
    required this.label,
    this.rich = false,
    this.text = '',
    this.hintText,
    this.initialValue,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
  }) {
    init();
  }

  final String label;
  final String text;
  final String? hintText;
  final bool rich;

  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final bool readOnly;
  final ToolbarOptions? toolbarOptions;
  final bool? showCursor;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final ScrollController? scrollController;
  final String? restorationId;
  final bool enableIMEPersonalizedLearning;

  late final TextEditingController controller;
  late final TextEditingControllerStream stream;
  // late final StreamSubscription subscription;

  static double buttonSize = 40;

  void init() {
    controller = TextEditingController(text: text);
    stream = TextEditingControllerStream(controller);
  }

  @override
  StreamSubscription<String> listen(
    void Function(String event)? onData, {
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
  String get value => controller.text;

  @override
  Widget build(BuildContext context) {
    if (!rich) {
      return _buildInput(context);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRichControls(context),
        _buildInput(context),
      ],
    );
  }

  Widget _buildInput(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      decoration: decoration?.copyWith(
        hintText: hintText,
        label: Text(label),
      ),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      style: style,
      strutStyle: strutStyle,
      textDirection: textDirection,
      textAlign: textAlign,
      textAlignVertical: textAlignVertical,
      autofocus: autofocus,
      readOnly: readOnly,
      toolbarOptions: toolbarOptions,
      showCursor: showCursor,
      obscuringCharacter: obscuringCharacter,
      obscureText: obscureText,
      autocorrect: autocorrect,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      maxLength: maxLength,
      onChanged: onChanged,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
      enabled: enabled,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      keyboardAppearance: keyboardAppearance,
      scrollPadding: scrollPadding,
      enableInteractiveSelection: enableInteractiveSelection,
      selectionControls: selectionControls,
      buildCounter: buildCounter,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      autovalidateMode: autovalidateMode,
      scrollController: scrollController,
      restorationId: restorationId,
      enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
    );
  }

  SizedBox _buildRichControls(BuildContext context) {
    return SizedBox(
      height: buttonSize,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          RichButton(
            icon: const Icon(Icons.format_bold),
            tooltip: 'Bold',
            onTap: _wrapOrAppendCb('**bold**', '**'),
          ),
          RichButton(
            icon: const Icon(Icons.format_italic),
            tooltip: 'Italic',
            onTap: _wrapOrAppendCb('*italic*', '*'),
          ),
          RichButton(
            icon: const Icon(Icons.format_list_bulleted),
            tooltip: 'Bullet List',
            onTap: _wrapOrAppendCb('\n* ', '\n* '),
          ),
          RichButton(
            icon: const Icon(Icons.format_list_numbered),
            tooltip: 'Number List',
            onTap: _wrapOrAppendCb('\n1. ', '\n1. '),
          ),
          RichButton(
            icon: const Icon(Icons.link),
            tooltip: 'URL',
            onTap: _wrapOrAppendCb('[text](url)', '[', '](url)'),
          ),
          RichButton(
            icon: const Icon(Icons.image),
            tooltip: 'Image URL',
            onTap: _wrapOrAppendCb('![alt](url)', '![alt][', ']'),
          ),
        ],
      ),
    );
  }

  void _wrapWith(String prefix, [String? suffix]) {
    if (controller.selection.isValid) {
      final selection = controller.selection.copyWith(
        baseOffset: controller.selection.baseOffset + prefix.length,
        extentOffset: controller.selection.extentOffset + prefix.length,
      );
      // final start =
      controller.text = [
        if (controller.selection.start > 0)
          controller.text.substring(0, controller.selection.start),
        prefix,
        controller.text.substring(controller.selection.start, controller.selection.end),
        suffix ?? prefix,
        if (controller.selection.end < controller.text.length)
          controller.text.substring(controller.selection.end, controller.text.length),
      ].join('');
      controller.selection = selection;
    }
  }

  void _append(String text) {
    final selection = controller.selection.copyWith(
      baseOffset: controller.selection.baseOffset + text.length,
      extentOffset: controller.selection.extentOffset + text.length,
    );
    if (controller.selection.isValid) {
      controller.text = [
        controller.text.substring(0, controller.selection.start),
        text,
        controller.text.substring(controller.selection.start, controller.text.length),
      ].join('');
    } else {
      controller.text += text;
    }
    controller.selection = selection;
  }

  void Function() _wrapOrAppendCb(String text, String prefix, [String? suffix]) {
    var _suffix = suffix ?? prefix;
    if (controller.text.trim().isEmpty) {
      text = text.replaceAll('\n', '');
      prefix = prefix.replaceAll('\n', '');
      _suffix = _suffix.replaceAll('\n', '');
    }
    return () {
      if (!controller.selection.isCollapsed) {
        _wrapWith(prefix, suffix);
      } else {
        _append(text);
      }
    };
  }
}

class RichButton extends StatelessWidget {
  const RichButton({
    Key? key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
  }) : super(key: key);

  final Widget icon;
  final String tooltip;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: FormTextInputData.buttonSize,
      height: FormTextInputData.buttonSize,
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: onTap,
          child: icon,
        ),
      ),
    );
  }
}
