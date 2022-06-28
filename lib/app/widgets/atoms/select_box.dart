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
    final enabled = onChanged != null;
    final hasLabel = label != null;
    final height = hasLabel ? 62.5 : 48.0;
    final theme = Theme.of(context);

    const Color darkEnabled = Color(0x1AFFFFFF);
    const Color darkDisabled = Color(0x0DFFFFFF);
    const Color lightEnabled = Color(0x0A000000);
    const Color lightDisabled = Color(0x05000000);

    final fill = theme.brightness == Brightness.dark
        ? enabled
            ? darkEnabled
            : darkDisabled
        : enabled
            ? lightEnabled
            : lightDisabled;

    final borderColor = theme.brightness == Brightness.dark
        ? Colors.white.withOpacity(0.55)
        : Colors.black.withOpacity(0.55);

    return SizedBox(
      height: height,
      child: InputDecorator(
        decoration: InputDecoration(
          label: label,
          enabled: enabled,
          border: Theme.of(context).inputDecorationTheme.border,
        ),
        child: buildDropdown(),
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
