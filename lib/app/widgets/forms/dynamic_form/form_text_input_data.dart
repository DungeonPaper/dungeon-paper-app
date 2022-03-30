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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final mdTheme = MarkdownStyleSheet.fromTheme(theme);
    const divider = Padding(padding: EdgeInsets.symmetric(vertical: 8), child: VerticalDivider());
    const thinDivider = Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: VerticalDivider(
        width: 4,
      ),
    );
    return SizedBox(
      height: buttonSize,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          RichButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.preview_outlined),
            tooltip: S.current.formatPreview,
            onTap: () => _openPreview(context),
          ),
          RichButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.help),
            tooltip: S.current.formatHelp,
            onTap: () => launch('https://www.markdownguide.org/basic-syntax'),
          ),
          thinDivider,
          RichButton(
            icon: const Icon(Icons.format_bold),
            tooltip: S.current.formatBold,
            onTap: _wrapOrAppendCb('**bold**', '**', null, 2, -2),
          ),
          RichButton(
            icon: const Icon(Icons.format_italic),
            tooltip: S.current.formatItalic,
            onTap: _wrapOrAppendCb('*italic*', '*', null, 1, -1),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: Text(S.current.formatHeading(1), style: mdTheme.h1), value: 'h1'),
              PopupMenuItem(
                  child: Text(S.current.formatHeading(2), style: mdTheme.h2), value: 'h2'),
              PopupMenuItem(
                  child: Text(S.current.formatHeading(3), style: mdTheme.h3), value: 'h3'),
              PopupMenuItem(
                  child: Text(S.current.formatHeading(4), style: mdTheme.h4), value: 'h4'),
              PopupMenuItem(
                  child: Text(S.current.formatHeading(5), style: mdTheme.h5), value: 'h5'),
              PopupMenuItem(
                  child: Text(S.current.formatHeading(6), style: mdTheme.h6), value: 'h6'),
            ],
            onSelected: (value) => {
              for (var i = 1; i <= 6; i++)
                'h$i': _wrapOrAppendCb(
                  '\n${List.filled(i, "#").join("")} ${S.current.formatHeading(i)}\n',
                  '\n${List.filled(i, "#").join("")} ',
                  '\n',
                  2 + i,
                  -1,
                ),
            }[value]
                ?.call(),
            child: RichButton(
              icon: Icon(Icons.format_size),
              tooltip: S.current.formatHeadings,
            ),
          ),
          divider,
          RichButton(
            icon: const Icon(Icons.format_list_bulleted),
            tooltip: S.current.formatBulletList,
            onTap: _wrapOrAppendCb('\n* ', '\n* '),
          ),
          RichButton(
            icon: const Icon(Icons.format_list_numbered),
            tooltip: S.current.formatNumberedList,
            onTap: _wrapOrAppendCb('\n1. ', '\n1. '),
          ),
          divider,
          RichButton(
            icon: const Icon(Icons.link),
            tooltip: S.current.formatURL,
            onTap: _wrapOrAppendCb('[text](url)', '[', '](url)', 7, -1),
          ),
          RichButton(
            icon: const Icon(Icons.image),
            tooltip: S.current.formatImageURL,
            onTap: _wrapOrAppendCb('![alt](url)', '![alt][', ']', 7, -1),
          ),
          RichButton(
            icon: const Icon(Icons.table_chart_outlined),
            tooltip: S.current.formatTable,
            onTap: _wrapOrAppendCb(
                '| ${S.current.formatHeader(1)} '
                    '| ${S.current.formatHeader(2)} '
                    '|\n|---|---|\n'
                    '| ${S.current.formatCell(1)} '
                    '| ${S.current.formatCell(2)} |',
                '| ${S.current.formatHeader(' ')}|\n|---|\n| ',
                ' |',
                2,
                -43),
          ),
        ],
      ),
    );
  }

  void _wrapWith(String prefix, [String? suffix]) {
    if (controller.selection.isValid) {
      // has selection - wrap current cursor positions
      final selection = controller.selection.copyWith(
        baseOffset: controller.selection.baseOffset + prefix.length,
        extentOffset: controller.selection.extentOffset + prefix.length,
      );
      controller.text = [
        if (controller.selection.start > 0)
          controller.text.substring(0, controller.selection.start),
        prefix,
        controller.text.substring(controller.selection.start, controller.selection.end),
        suffix ?? prefix,
        if (controller.selection.end < controller.text.length)
          controller.text.substring(controller.selection.end, controller.text.length),
      ].join('');
      try {
        controller.selection = selection;
      } catch (e) {
        // don't crash when selection is invalid
      }
    }
  }

  void _append(String text, [int? selectionStartOffset, int? selectionEndOffset]) {
    if (controller.selection.isValid) {
      // has cursor - append at cursor position
      final selection = controller.selection.copyWith(
        baseOffset: controller.selection.baseOffset + (selectionStartOffset ?? 0),
        extentOffset: controller.selection.extentOffset + text.length + (selectionEndOffset ?? 0),
      );
      controller.text = [
        controller.text.substring(0, controller.selection.start),
        text,
        controller.text.substring(controller.selection.start, controller.text.length),
      ].join('');
      try {
        controller.selection = selection;
      } catch (e) {
        // don't crash when selection is invalid
      }
    } else {
      // no cursor - append to end of text
      final selection = controller.selection.copyWith(
        baseOffset: selectionStartOffset ?? 0,
        extentOffset: text.length + (selectionEndOffset ?? 0),
      );
      controller.text += text;
      try {
        controller.selection = selection;
      } catch (e) {
        // don't crash when selection is invalid
      }
    }
  }

  void Function() _wrapOrAppendCb(String text, String prefix,
      [String? suffix, int? selectionStartOffset, int? selectionEndOffset]) {
    var _suffix = suffix ?? prefix;

    // if text is empty, or selection starts directly after newline - remove prefix newlines
    if (controller.text.trim().isEmpty ||
        (controller.selection.isValid &&
            controller.text.substring(
                    max(controller.selection.start - 1, 0), controller.selection.start) ==
                '\n')) {
      final originalText = text;
      text = text.replaceAll('\n', '');
      prefix = prefix.replaceAll('\n', '');
      _suffix = _suffix.replaceAll('\n', '');
      if (originalText.startsWith('\n') && selectionStartOffset != null) {
        selectionStartOffset -= 1;
      }
      if (originalText.endsWith('\n') && selectionEndOffset != null) {
        selectionEndOffset += 1;
      }
    }
    return () {
      if (!controller.selection.isCollapsed) {
        _wrapWith(prefix, suffix);
      } else {
        _append(text, selectionStartOffset, selectionEndOffset);
      }
    };
  }

  void _openPreview(BuildContext context) {
    Get.dialog(
      MarkdownPreviewDialog(text: controller.text),
    );
  }
}

class MarkdownPreviewDialog extends StatelessWidget {
  const MarkdownPreviewDialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orient) {
      return AlertDialog(
        title: const Text('Preview'),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 100,
            maxWidth: MediaQuery.of(context).size.width - 100,
            maxHeight: MediaQuery.of(context).size.height - 100,
            minHeight: 10,
          ),
          child: Markdown(
            data: text.trim().isNotEmpty ? text : S.current.noDescription,
            padding: const EdgeInsets.all(0),
            onTapLink: (text, href, title) => launch(href!),
            shrinkWrap: true,
          ),
        ),
      );
    });
  }
}

class RichButton extends StatelessWidget {
  const RichButton({
    Key? key,
    required this.icon,
    required this.tooltip,
    this.onTap,
    this.color,
  }) : super(key: key);

  final Widget icon;
  final String tooltip;
  final void Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var child = IconTheme.merge(data: IconThemeData(color: color), child: icon);
    return SizedBox(
      width: FormTextInputData.buttonSize,
      height: FormTextInputData.buttonSize,
      child: Tooltip(
        message: tooltip,
        child: onTap != null
            ? InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: onTap,
                child: child,
              )
            : child,
      ),
    );
  }
}
