import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:flutter/material.dart';

class SelectBox<T> extends StatelessWidget {
  const SelectBox({
    Key? key,
    //
    this.label,
    //

    required this.items,
    this.selectedItemBuilder,
    this.value,
    this.hint,
    this.disabledHint,
    required this.onChanged,
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
  }) : super(key: key);

  //
  final Widget? label;
  //

  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final Widget? hint;
  final Widget? disabledHint;
  final ValueChanged<T?>? onChanged;
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

  @override
  Widget build(BuildContext context) {
    final enabled = value != null || onChanged != null;

    if (label == null) {
      return _Container(
        disabled: !enabled,
        // color: Colors.red,
        child: buildDropdown(),
      );
    }

    final theme = Theme.of(context);

    // return ConstrainedBox(
    //   constraints: BoxConstraints(minWidth: 80, maxWidth: 170),
    //   child: InputDecorator(
    //     decoration: InputDecoration(
    //       // contentPadding: EdgeInsets.only(top: 8),
    //       filled: true,
    //       label: label,
    //     ),
    //     child: buildDropdown(),
    //   ),
    // );

    return _Container(
      disabled: !enabled,
      label: true,
      // color: Colors.red,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1, left: 3),
            child: DefaultTextStyle(style: theme.textTheme.caption!, child: label!),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 3, bottom: 2),
            child: buildDropdown(),
          ),
        ],
      ),
    );
  }

  DropdownButton<dynamic> buildDropdown() {
    return DropdownButton<T>(
      alignment: alignment,
      autofocus: autofocus,
      borderRadius: borderRadius ?? rRectShape.borderRadius.resolve(TextDirection.ltr),
      disabledHint: disabledHint,
      dropdownColor: dropdownColor,
      elevation: elevation,
      enableFeedback: enableFeedback,
      focusColor: focusColor,
      focusNode: focusNode,
      hint: hint,
      icon: icon,
      iconDisabledColor: iconDisabledColor,
      iconEnabledColor: iconEnabledColor,
      iconSize: iconSize,
      isDense: isDense,
      isExpanded: isExpanded,
      itemHeight: itemHeight,
      items: items,
      menuMaxHeight: menuMaxHeight,
      onChanged: onChanged,
      onTap: onTap,
      selectedItemBuilder: selectedItemBuilder,
      style: style,
      underline: underline ?? Container(),
      value: value,
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({Key? key, this.disabled = false, required this.child, this.label = false})
      : super(key: key);

  final bool disabled;
  final Widget child;
  final bool label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const Color darkEnabled = Color(0x1AFFFFFF);
    const Color darkDisabled = Color(0x0DFFFFFF);
    const Color lightEnabled = Color(0x0A000000);
    const Color lightDisabled = Color(0x05000000);

    final height = label ? 62.5 : 48.0;

    final fill = theme.brightness == Brightness.dark
        ? !disabled
            ? darkEnabled
            : darkDisabled
        : !disabled
            ? lightEnabled
            : lightDisabled;

    final borderColor = theme.brightness == Brightness.dark
        ? Colors.white.withOpacity(0.55)
        : Colors.black.withOpacity(0.55);

    return Container(
      decoration: BoxDecoration(
        color: fill,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              style: BorderStyle.solid,
              color: borderColor,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(bottom: label ? 0.0 : 8.0),
          child: child,
        ),
      ),
    );
  }
}
