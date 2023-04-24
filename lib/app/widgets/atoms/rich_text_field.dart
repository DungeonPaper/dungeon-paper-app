import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/core/utils/markdown_styles.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RichTextField extends StatelessWidget {
  RichTextField({
    Key? key,
    this.controller,
    this.label,
    this.rich = true,
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
    //
    this.customButtons,
  }) : super(key: key);

  final String? label;
  final String text;
  final String? hintText;
  final bool rich;
  final TextEditingController? controller;

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
  final _defaultController = TextEditingController().obs;
  TextEditingController get _controller =>
      controller ?? _defaultController.value;
  final List<RichButton>? customButtons;

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
    final _label = label != null ? Text(label!) : null;

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      decoration: decoration?.copyWith(
            hintText: hintText,
            label: _label,
          ) ??
          InputDecoration(
            filled: true,
            hintText: hintText,
            label: _label,
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
    final mdTheme = MarkdownStyles.of(context);
    const divider = Padding(
        padding: EdgeInsets.symmetric(vertical: 8), child: VerticalDivider());
    const thinDivider = Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: VerticalDivider(width: 4),
    );
    final builder = ItemBuilder.lazyChildren(
      children: [
        () => _RichButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: const Icon(Icons.preview_outlined),
              tooltip: S.current.formatPreview,
              onTap: () => _openPreview(context),
            ),
        () => _RichButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: const Icon(Icons.help),
              tooltip: S.current.formatHelp,
              onTap: () => launchUrl(
                  Uri.parse('https://www.markdownguide.org/basic-syntax')),
            ),
        if (customButtons?.isNotEmpty == true) () => thinDivider,
        if (customButtons?.isNotEmpty == true)
          ...customButtons!.map(
            (button) => () => button.buildButton(context, _controller),
          ),
        () => thinDivider,
        () => RichButton(
              icon: Icons.format_bold,
              tooltip: S.current.formatBold,
              defaultContent: '**bold**',
              prefix: '**',
              selectionStartOffset: 2,
              selectionEndOffset: -2,
            ).buildButton(context, _controller),
        () => RichButton(
              icon: Icons.format_italic,
              tooltip: S.current.formatItalic,
              defaultContent: '*italic*',
              prefix: '*',
              selectionStartOffset: 1,
              selectionEndOffset: -1,
            ).buildButton(context, _controller),
        () => RichButton.dropdown(
              icon: Icons.format_size,
              tooltip: S.current.formatHeadings,
              actions: List.generate(6, (i) => i + 1)
                  .map(
                    (i) => RichButtonAction.dropdownItem(
                      text: Text(
                        S.current.formatHeading(i),
                        style: {
                          'h1': mdTheme.h1,
                          'h2': mdTheme.h2,
                          'h3': mdTheme.h3,
                          'h4': mdTheme.h4,
                          'h5': mdTheme.h5,
                          'h6': mdTheme.h6,
                        }['h$i']!,
                      ),
                      defaultContent:
                          '\n${List.filled(i, "#").join("")} ${S.current.formatHeading(i)}\n',
                      prefix: '\n${List.filled(i, "#").join("")} ',
                      suffix: '\n',
                      selectionStartOffset: 2 + i,
                      selectionEndOffset: -1,
                    ),
                  )
                  .toList(),
            ).buildButton(context, _controller),
        () => divider,
        () => RichButton(
              icon: Icons.format_list_bulleted,
              tooltip: S.current.formatBulletList,
              defaultContent: '\n- ',
              prefix: '\n- ',
            ).buildButton(context, _controller),
        () => RichButton(
              icon: Icons.format_list_numbered,
              tooltip: S.current.formatNumberedList,
              defaultContent: '\n1. ',
              prefix: '\n1. ',
            ).buildButton(context, _controller),
        () => RichButton(
              icon: Icons.check_box_outline_blank,
              tooltip: S.current.formatCheckboxListUnchecked,
              defaultContent: '\n- [ ] ',
              prefix: '\n- [ ] ',
              selectionStartOffset: 7,
            ).buildButton(context, _controller),
        () => RichButton(
              icon: Icons.check_box_outlined,
              tooltip: S.current.formatCheckboxList,
              defaultContent: '\n- [x] ',
              prefix: '\n- [x] ',
              selectionStartOffset: 7,
            ).buildButton(context, _controller),
        () => divider,
        () => RichButton(
              icon: Icons.link,
              tooltip: S.current.formatURL,
              defaultContent: '[text](url)',
              prefix: '[',
              suffix: '](url)',
              selectionStartOffset: 7,
              selectionEndOffset: -1,
            ).buildButton(context, _controller),
        () => RichButton(
              icon: Icons.image,
              tooltip: S.current.formatImageURL,
              defaultContent: '![alt](url)',
              prefix: '![alt][',
              suffix: ']',
              selectionStartOffset: 7,
              selectionEndOffset: -1,
            ).buildButton(context, _controller),
        () => RichButton(
              icon: Icons.table_chart_outlined,
              tooltip: S.current.formatTable,
              defaultContent: '| ${S.current.formatHeader(1)} '
                  '| ${S.current.formatHeader(2)} '
                  '|\n|---|---|\n'
                  '| ${S.current.formatCell(1)} '
                  '| ${S.current.formatCell(2)} |',
              prefix: '| ${S.current.formatHeader(' ')}|\n|---|\n| ',
              suffix: ' |',
              selectionStartOffset: 2,
              selectionEndOffset: -43,
            ).buildButton(context, _controller),
      ],
    );
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: builder.itemBuilder,
        itemCount: builder.itemCount,
      ),
    );
  }

  void _openPreview(BuildContext context) {
    Get.dialog(
      MarkdownPreviewDialog(text: _controller.text),
    );
  }
}

class _RichButton extends StatelessWidget {
  const _RichButton({
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
      width: 40,
      height: 40,
      child: Tooltip(
        message: tooltip,
        child: onTap != null
            ? InkWell(
                splashColor: Theme.of(context).splashColor,
                borderRadius: BorderRadius.circular(4),
                onTap: onTap,
                child: child,
              )
            : child,
      ),
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
        title: Text(S.current.markdownPreview),
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
            onTapLink: (text, href, title) => launchUrl(Uri.parse(href!)),
            shrinkWrap: true,
            styleSheet: MarkdownStyles.of(context),
          ),
        ),
      );
    });
  }
}

class RichButtonAction {
  final Widget text;
  final String defaultContent;
  final String prefix;
  final String? suffix;
  final int? selectionStartOffset;
  final int? selectionEndOffset;

  RichButtonAction({
    required this.defaultContent,
    required this.prefix,
    this.suffix,
    this.selectionStartOffset,
    this.selectionEndOffset,
  }) : text = const Text('');

  RichButtonAction.dropdownItem({
    required this.text,
    required this.defaultContent,
    required this.prefix,
    this.suffix,
    this.selectionStartOffset,
    this.selectionEndOffset,
  });
}

class RichButton {
  final IconData icon;
  final String tooltip;
  final List<RichButtonAction> actions;
  final Color? color;

  RichButton.dropdown({
    required this.icon,
    required this.tooltip,
    required this.actions,
    this.color,
  });

  RichButton({
    required this.icon,
    required this.tooltip,
    this.color,
    required String defaultContent,
    required String prefix,
    String? suffix,
    int? selectionStartOffset,
    int? selectionEndOffset,
  }) : actions = [
          RichButtonAction(
            defaultContent: defaultContent,
            prefix: prefix,
            suffix: suffix,
            selectionStartOffset: selectionStartOffset,
            selectionEndOffset: selectionEndOffset,
          )
        ];

  bool get isSingle => actions.length == 1;

  RichButtonAction get singleAction => actions.first;

  Widget buildButton(BuildContext context, TextEditingController controller) {
    if (isSingle) {
      return _RichButton(
        icon: Icon(icon),
        tooltip: tooltip,
        onTap: _wrapOrAppendCb(
          controller,
          singleAction.defaultContent,
          singleAction.prefix,
          singleAction.suffix,
          singleAction.selectionStartOffset,
          singleAction.selectionEndOffset,
        ),
      );
    }
    return MenuButton(
      items: actions.map(
        (action) => MenuEntry(
          label: action.text,
          value: action.defaultContent,
          onSelect: _wrapOrAppendCb(
            controller,
            action.defaultContent,
            action.prefix,
            action.suffix,
            action.selectionStartOffset,
            action.selectionEndOffset,
          ),
        ),
      ),
      child: _RichButton(
        icon: Icon(icon),
        tooltip: tooltip,
      ),
    );
  }

  void _wrapWith(TextEditingController controller, String prefix,
      [String? suffix]) {
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
        controller.text
            .substring(controller.selection.start, controller.selection.end),
        suffix ?? prefix,
        if (controller.selection.end < controller.text.length)
          controller.text
              .substring(controller.selection.end, controller.text.length),
      ].join('');
      try {
        controller.selection = selection;
      } catch (e) {
        // don't crash when selection is invalid
      }
    }
  }

  void _append(TextEditingController controller, String text,
      [int? selectionStartOffset, int? selectionEndOffset]) {
    if (controller.selection.isValid) {
      // has cursor - append at cursor position
      final selection = controller.selection.copyWith(
        baseOffset:
            controller.selection.baseOffset + (selectionStartOffset ?? 0),
        extentOffset: controller.selection.extentOffset +
            text.length +
            (selectionEndOffset ?? 0),
      );
      controller.text = [
        controller.text.substring(0, controller.selection.start),
        text,
        controller.text
            .substring(controller.selection.start, controller.text.length),
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

  void Function() _wrapOrAppendCb(
      TextEditingController controller, String defaultContent, String prefix,
      [String? suffix, int? selectionStartOffset, int? selectionEndOffset]) {
    var _suffix = suffix ?? prefix;

    // if text is empty, or selection starts directly after newline - remove prefix newlines
    // if (controller.text.trim().isEmpty ||
    //     (controller.selection.isValid &&
    //         controller.text.substring(
    //                 max(controller.selection.start - 1, 0), controller.selection.start) ==
    //             '\n')) {
    //   final originalText = text;
    //   text = text.trimLeft();
    //   prefix = prefix.trimLeft();
    //   // _suffix = _suffix.trimLeft();
    //   if (originalText.startsWith('\n') && selectionStartOffset != null) {
    //     selectionStartOffset -= 1;
    //   }
    //   if (originalText.endsWith('\n') && selectionEndOffset != null) {
    //     selectionEndOffset += 1;
    //   }
    // }
    return () {
      if (!controller.selection.isCollapsed) {
        _wrapWith(controller, prefix, _suffix);
      } else {
        _append(controller, defaultContent, selectionStartOffset,
            selectionEndOffset);
      }
    };
  }
}
