import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget leading;
  final bool automaticallyImplyLeading;
  final Widget title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final Color shadowColor;
  final ShapeBorder shape;
  final Color backgroundColor;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final IconThemeData actionsIconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final bool excludeHeaderSemantics;
  final double titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double toolbarHeight;
  final double leadingWidth;

  MainAppBar({
    Key key,
    this.leading,
    this.automaticallyImplyLeading = true,
    @required this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.backgroundColor,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.leadingWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final _textTheme = (textTheme ?? theme.textTheme)
        .apply(bodyColor: theme.colorScheme.secondary);
    final _iconTheme = (iconTheme ?? theme.iconTheme)
        .copyWith(color: theme.colorScheme.secondary);

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      shadowColor: shadowColor,
      shape: shape,
      backgroundColor: backgroundColor,
      brightness: brightness,
      iconTheme: _iconTheme,
      actionsIconTheme: actionsIconTheme,
      textTheme: _textTheme,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
    );
  }

  @override
  final preferredSize = Size.fromHeight(50.0);
}
