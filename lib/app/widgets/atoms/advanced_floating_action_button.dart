// ignore_for_file: unnecessary_null_comparison

import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:flutter/material.dart';

class AdvancedFloatingActionButton extends StatelessWidget {
  /// Creates a circular floating action button.
  ///
  /// The [mini] and [clipBehavior] arguments must not be null. Additionally,
  /// [elevation], [highlightElevation], and [disabledElevation] (if specified)
  /// must be non-negative.
  const AdvancedFloatingActionButton({
    Key? key,
    this.child,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor = DwColors.success,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.heroTag = const _DefaultHeroTag(),
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    required this.onPressed,
    this.mouseCursor,
    this.mini = false,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.isExtended = false,
    this.enableFeedback,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(focusElevation == null || focusElevation >= 0.0),
        assert(hoverElevation == null || hoverElevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        assert(mini != null),
        assert(clipBehavior != null),
        assert(isExtended != null),
        assert(autofocus != null),
        _floatingActionButtonType = mini ? _FloatingActionButtonType.small : _FloatingActionButtonType.regular,
        _extendedLabel = null,
        extendedIconLabelSpacing = null,
        extendedPadding = null,
        extendedTextStyle = null,
        super(key: key);

  /// Creates a small circular floating action button.
  ///
  /// This constructor overrides the default size constraints of the floating
  /// action button.
  ///
  /// The [clipBehavior] and [autofocus] arguments must not be null.
  /// Additionally, [elevation], [focusElevation], [hoverElevation],
  /// [highlightElevation], and [disabledElevation] (if specified) must be
  /// non-negative.
  const AdvancedFloatingActionButton.small({
    Key? key,
    this.child,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.heroTag = const _DefaultHeroTag(),
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    required this.onPressed,
    this.mouseCursor,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.enableFeedback,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(focusElevation == null || focusElevation >= 0.0),
        assert(hoverElevation == null || hoverElevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        assert(clipBehavior != null),
        assert(autofocus != null),
        _floatingActionButtonType = _FloatingActionButtonType.small,
        mini = true,
        isExtended = false,
        _extendedLabel = null,
        extendedIconLabelSpacing = null,
        extendedPadding = null,
        extendedTextStyle = null,
        super(key: key);

  /// Creates a large circular floating action button.
  ///
  /// This constructor overrides the default size constraints of the floating
  /// action button.
  ///
  /// The [clipBehavior] and [autofocus] arguments must not be null.
  /// Additionally, [elevation], [focusElevation], [hoverElevation],
  /// [highlightElevation], and [disabledElevation] (if specified) must be
  /// non-negative.
  const AdvancedFloatingActionButton.large({
    Key? key,
    this.child,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.heroTag = const _DefaultHeroTag(),
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    required this.onPressed,
    this.mouseCursor,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.materialTapTargetSize,
    this.enableFeedback,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(focusElevation == null || focusElevation >= 0.0),
        assert(hoverElevation == null || hoverElevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        assert(clipBehavior != null),
        assert(autofocus != null),
        _floatingActionButtonType = _FloatingActionButtonType.large,
        mini = false,
        isExtended = false,
        _extendedLabel = null,
        extendedIconLabelSpacing = null,
        extendedPadding = null,
        extendedTextStyle = null,
        super(key: key);

  /// Creates a wider [StadiumBorder]-shaped floating action button with
  /// an optional [icon] and a [label].
  ///
  /// The [label], [autofocus], and [clipBehavior] arguments must not be null.
  /// Additionally, [elevation], [highlightElevation], and [disabledElevation]
  /// (if specified) must be non-negative.
  const AdvancedFloatingActionButton.extended({
    Key? key,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.focusColor,
    this.hoverColor,
    this.heroTag = const _DefaultHeroTag(),
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.splashColor,
    this.highlightElevation,
    this.disabledElevation,
    required this.onPressed,
    this.mouseCursor = SystemMouseCursors.click,
    this.shape,
    this.isExtended = true,
    this.materialTapTargetSize,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.extendedIconLabelSpacing,
    this.extendedPadding,
    this.extendedTextStyle,
    Widget? icon,
    required Widget label,
    this.enableFeedback,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(focusElevation == null || focusElevation >= 0.0),
        assert(hoverElevation == null || hoverElevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        assert(isExtended != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        mini = false,
        _floatingActionButtonType = _FloatingActionButtonType.extended,
        child = icon,
        _extendedLabel = label,
        super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// Typically an [Icon].
  final Widget? child;

  /// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String? tooltip;

  /// The default foreground color for icons and text within the button.
  ///
  /// If this property is null, then the
  /// [FloatingActionButtonThemeData.foregroundColor] of
  /// [ThemeData.floatingActionButtonTheme] is used. If that property is also
  /// null, then the [ColorScheme.onSecondary] color of [ThemeData.colorScheme]
  /// is used.
  final Color? foregroundColor;

  /// The button's background color.
  ///
  /// If this property is null, then the
  /// [FloatingActionButtonThemeData.backgroundColor] of
  /// [ThemeData.floatingActionButtonTheme] is used. If that property is also
  /// null, then the [Theme]'s [ColorScheme.secondary] color is used.
  final Color? backgroundColor;

  /// The color to use for filling the button when the button has input focus.
  ///
  /// Defaults to [ThemeData.focusColor] for the current theme.
  final Color? focusColor;

  /// The color to use for filling the button when the button has a pointer
  /// hovering over it.
  ///
  /// Defaults to [ThemeData.hoverColor] for the current theme.
  final Color? hoverColor;

  /// The splash color for this [AdvancedFloatingActionButton]'s [InkWell].
  ///
  /// If null, [FloatingActionButtonThemeData.splashColor] is used, if that is
  /// null, [ThemeData.splashColor] is used.
  final Color? splashColor;

  /// The tag to apply to the button's [Hero] widget.
  ///
  /// Defaults to a tag that matches other floating action buttons.
  ///
  /// Set this to null explicitly if you don't want the floating action button to
  /// have a hero tag.
  ///
  /// If this is not explicitly set, then there can only be one
  /// [AdvancedFloatingActionButton] per route (that is, per screen), since otherwise
  /// there would be a tag conflict (multiple heroes on one route can't have the
  /// same tag). The material design specification recommends only using one
  /// floating action button per screen.
  final Object? heroTag;

  /// The callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this is set to null, the button will be disabled.
  final VoidCallback? onPressed;

  /// {@macro flutter.material.RawMaterialButton.mouseCursor}
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// The z-coordinate at which to place this button relative to its parent.
  ///
  /// This controls the size of the shadow below the floating action button.
  ///
  /// Defaults to 6, the appropriate elevation for floating action buttons. The
  /// value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [highlightElevation], the elevation when the button is pressed.
  ///  * [disabledElevation], the elevation when the button is disabled.
  final double? elevation;

  /// The z-coordinate at which to place this button relative to its parent when
  /// the button has the input focus.
  ///
  /// This controls the size of the shadow below the floating action button.
  ///
  /// Defaults to 8, the appropriate elevation for floating action buttons
  /// while they have focus. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [highlightElevation], the elevation when the button is pressed.
  ///  * [disabledElevation], the elevation when the button is disabled.
  final double? focusElevation;

  /// The z-coordinate at which to place this button relative to its parent when
  /// the button is enabled and has a pointer hovering over it.
  ///
  /// This controls the size of the shadow below the floating action button.
  ///
  /// Defaults to 8, the appropriate elevation for floating action buttons while
  /// they have a pointer hovering over them. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [highlightElevation], the elevation when the button is pressed.
  ///  * [disabledElevation], the elevation when the button is disabled.
  final double? hoverElevation;

  /// The z-coordinate at which to place this button relative to its parent when
  /// the user is touching the button.
  ///
  /// This controls the size of the shadow below the floating action button.
  ///
  /// Defaults to 12, the appropriate elevation for floating action buttons
  /// while they are being touched. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  final double? highlightElevation;

  /// The z-coordinate at which to place this button when the button is disabled
  /// ([onPressed] is null).
  ///
  /// This controls the size of the shadow below the floating action button.
  ///
  /// Defaults to the same value as [elevation]. Setting this to zero makes the
  /// floating action button work similar to an [ElevatedButton] but the titular
  /// "floating" effect is lost. The value is always non-negative.
  ///
  /// See also:
  ///
  ///  * [elevation], the default elevation.
  ///  * [highlightElevation], the elevation when the button is pressed.
  final double? disabledElevation;

  /// Controls the size of this button.
  ///
  /// By default, floating action buttons are non-mini and have a height and
  /// width of 56.0 logical pixels. Mini floating action buttons have a height
  /// and width of 40.0 logical pixels with a layout width and height of 48.0
  /// logical pixels. (The extra 4 pixels of padding on each side are added as a
  /// result of the floating action button having [MaterialTapTargetSize.padded]
  /// set on the underlying [RawMaterialButton.materialTapTargetSize].)
  final bool mini;

  /// The shape of the button's [Material].
  ///
  /// The button's highlight and splash are clipped to this shape. If the
  /// button has an elevation, then its drop shadow is defined by this
  /// shape as well.
  final ShapeBorder? shape;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none], and must not be null.
  final Clip clipBehavior;

  /// True if this is an "extended" floating action button.
  ///
  /// Typically [extended] buttons have a [StadiumBorder] [shape]
  /// and have been created with the [FloatingActionButton.extended]
  /// constructor.
  ///
  /// The [Scaffold] animates the appearance of ordinary floating
  /// action buttons with scale and rotation transitions. Extended
  /// floating action buttons are scaled and faded in.
  final bool isExtended;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Configures the minimum size of the tap target.
  ///
  /// Defaults to [ThemeData.materialTapTargetSize].
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// If null, [FloatingActionButtonThemeData.enableFeedback] is used.
  /// If both are null, then default value is true.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// The spacing between the icon and the label for an extended
  /// [FloatingActionButton].
  ///
  /// If null, [FloatingActionButtonThemeData.extendedIconLabelSpacing] is used.
  /// If that is also null, the default is 8.0.
  final double? extendedIconLabelSpacing;

  /// The padding for an extended [FloatingActionButton]'s content.
  ///
  /// If null, [FloatingActionButtonThemeData.extendedPadding] is used. If that
  /// is also null, the default is
  /// `EdgeInsetsDirectional.only(start: 16.0, end: 20.0)` if an icon is
  /// provided, and `EdgeInsetsDirectional.only(start: 20.0, end: 20.0)` if not.
  final EdgeInsetsGeometry? extendedPadding;

  /// The text style for an extended [FloatingActionButton]'s label.
  ///
  /// If null, [FloatingActionButtonThemeData.extendedTextStyle] is used. If
  /// that is also null, then [TextTheme.labelLarge] with a letter spacing of 1.2
  /// is used.
  final TextStyle? extendedTextStyle;

  final _FloatingActionButtonType _floatingActionButtonType;

  final Widget? _extendedLabel;

  @override
  Widget build(BuildContext context) {
    final _fgColor = foregroundColor ?? (backgroundColor == DwColors.success ? Colors.white : null);
    final _bgColor = onPressed == null
        ? Theme.of(context).disabledColor.withOpacity(0.3)
        // ? Theme.of(context).brightness == Brightness.light
        //     ? Theme.of(context).disabledColor.withOpacity(0.3)
        //     : Theme.of(context).disabledColor.withOpacity(0.3)
        : backgroundColor;

    switch (_floatingActionButtonType) {
      case _FloatingActionButtonType.small:
        return FloatingActionButton.small(
          key: key,
          child: child,
          tooltip: tooltip,
          foregroundColor: _fgColor,
          backgroundColor: _bgColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          splashColor: splashColor,
          heroTag: heroTag,
          elevation: elevation,
          focusElevation: focusElevation,
          hoverElevation: hoverElevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          onPressed: onPressed,
          mouseCursor: mouseCursor,
          shape: shape,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          enableFeedback: enableFeedback,
        );
      case _FloatingActionButtonType.large:
        return FloatingActionButton.large(
          key: key,
          child: child,
          tooltip: tooltip,
          foregroundColor: _fgColor,
          backgroundColor: _bgColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          splashColor: splashColor,
          heroTag: heroTag,
          elevation: elevation,
          focusElevation: focusElevation,
          hoverElevation: hoverElevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          onPressed: onPressed,
          mouseCursor: mouseCursor,
          shape: shape,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          enableFeedback: enableFeedback,
        );
      case _FloatingActionButtonType.extended:
        return FloatingActionButton.extended(
          key: key,
          tooltip: tooltip,
          foregroundColor: _fgColor,
          backgroundColor: _bgColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          heroTag: heroTag,
          elevation: elevation,
          focusElevation: focusElevation,
          hoverElevation: hoverElevation,
          splashColor: splashColor,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          onPressed: onPressed,
          mouseCursor: mouseCursor,
          shape: shape,
          isExtended: isExtended,
          materialTapTargetSize: materialTapTargetSize,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          extendedIconLabelSpacing: extendedIconLabelSpacing,
          extendedPadding: extendedPadding,
          extendedTextStyle: extendedTextStyle,
          icon: child,
          label: _extendedLabel!,
        );
      default:
        return FloatingActionButton(
          child: child,
          tooltip: tooltip,
          foregroundColor: _fgColor,
          backgroundColor: _bgColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          splashColor: splashColor,
          heroTag: heroTag,
          onPressed: onPressed,
          mouseCursor: mouseCursor,
          elevation: elevation,
          focusElevation: focusElevation,
          hoverElevation: hoverElevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          mini: mini,
          shape: shape,
          clipBehavior: clipBehavior,
          isExtended: isExtended,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          enableFeedback: enableFeedback,
        );
    }
  }
}

class _DefaultHeroTag {
  const _DefaultHeroTag();
  @override
  String toString() => '<default FloatingActionButton tag>';
}

enum _FloatingActionButtonType {
  regular,
  small,
  large,
  extended,
}
