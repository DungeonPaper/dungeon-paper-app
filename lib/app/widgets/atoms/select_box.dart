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
      // color: Colors.red,
      child: Stack(
        children: [
          DefaultTextStyle(
              style: theme.textTheme.caption!.copyWith(fontSize: 11, fontWeight: FontWeight.w600),
              child: label!),
          Padding(padding: const EdgeInsets.only(top: 16), child: buildDropdown()),
        ],
      ),
    );
  }

  DropdownButton<dynamic> buildDropdown() {
    return DropdownButton<T>(
      items: items,
      value: value,
      hint: hint,
      disabledHint: disabledHint,
      onChanged: onChanged,
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
}

class _Container extends StatelessWidget {
  const _Container({Key? key, this.disabled = false, required this.child}) : super(key: key);

  final bool disabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const Color darkEnabled = Color(0x1AFFFFFF);
    const Color darkDisabled = Color(0x0DFFFFFF);
    const Color lightEnabled = Color(0x0A000000);
    const Color lightDisabled = Color(0x05000000);

    final fill = theme.brightness == Brightness.dark
        ? !disabled
            ? darkEnabled
            : darkDisabled
        : !disabled
            ? lightEnabled
            : lightDisabled;

    final borderColor = theme.brightness == Brightness.dark
        ? Colors.white.withOpacity(0.55)
        : Colors.white.withOpacity(0.5);

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
        height: 61,
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
          padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
          child: child,
        ),
      ),
    );
  }
}
