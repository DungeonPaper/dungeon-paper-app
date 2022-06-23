import 'package:dungeon_paper/app/widgets/atoms/popup_menu_item_list_tile.dart';
import 'package:flutter/material.dart';

class MenuButton<V> extends StatelessWidget {
  const MenuButton({
    Key? key,
    required Iterable<MenuEntry<V>> items,
    this.initialValue,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding = const EdgeInsets.all(8.0),
    this.child,
    this.splashRadius,
    this.icon,
    this.iconSize,
    this.offset = Offset.zero,
    this.enabled = true,
    this.shape,
    this.color,
    this.enableFeedback,
    this.constraints,
    this.position = PopupMenuPosition.over,
  })  : _items = items,
        builder = null,
        super(key: key);

  const MenuButton.builder({
    Key? key,
    required this.builder,
    this.initialValue,
    this.onCanceled,
    this.tooltip,
    this.elevation,
    this.padding = const EdgeInsets.all(8.0),
    this.child,
    this.splashRadius,
    this.icon,
    this.iconSize,
    this.offset = Offset.zero,
    this.enabled = true,
    this.shape,
    this.color,
    this.enableFeedback,
    this.constraints,
    this.position = PopupMenuPosition.over,
  })  : _items = null,
        assert(builder != null),
        super(key: key);

  final Iterable<MenuEntry<V>>? _items;
  final Iterable<MenuEntry<V>> Function()? builder;

  /// The value of the menu item, if any, that should be highlighted when the menu opens.
  final V? initialValue;

  /// Called when the user dismisses the popup menu without selecting an item.
  ///
  /// If the user selects a value, [onSelected] is called instead.
  final PopupMenuCanceled? onCanceled;

  /// Text that describes the action that will occur when the button is pressed.
  ///
  /// This text is displayed when the user long-presses on the button and is
  /// used for accessibility.
  final String? tooltip;

  /// The z-coordinate at which to place the menu when open. This controls the
  /// size of the shadow below the menu.
  ///
  /// Defaults to 8, the appropriate elevation for popup menus.
  final double? elevation;

  /// Matches IconButton's 8 dps padding by default. In some cases, notably where
  /// this button appears as the trailing element of a list item, it's useful to be able
  /// to set the padding to zero.
  final EdgeInsetsGeometry padding;

  /// The splash radius.
  ///
  /// If null, default splash radius of [InkWell] or [IconButton] is used.
  final double? splashRadius;

  /// If provided, [child] is the widget used for this button
  /// and the button will utilize an [InkWell] for taps.
  final Widget? child;

  /// If provided, the [icon] is used for this button
  /// and the button will behave like an [IconButton].
  final Widget? icon;

  /// The offset is applied relative to the initial position
  /// set by the [position].
  ///
  /// When not set, the offset defaults to [Offset.zero].
  final Offset offset;

  /// Whether this popup menu button is interactive.
  ///
  /// Must be non-null, defaults to `true`
  ///
  /// If `true` the button will respond to presses by displaying the menu.
  ///
  /// If `false`, the button is styled with the disabled color from the
  /// current [Theme] and will not respond to presses or show the popup
  /// menu and [onSelected], [onCanceled] and [itemBuilder] will not be called.
  ///
  /// This can be useful in situations where the app needs to show the button,
  /// but doesn't currently have anything to show in the menu.
  final bool enabled;

  /// If provided, the shape used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.shape] is used.
  /// If [PopupMenuThemeData.shape] is also null, then the default shape for
  /// [MaterialType.card] is used. This default shape is a rectangle with
  /// rounded edges of BorderRadius.circular(2.0).
  final ShapeBorder? shape;

  /// If provided, the background color used for the menu.
  ///
  /// If this property is null, then [PopupMenuThemeData.color] is used.
  /// If [PopupMenuThemeData.color] is also null, then
  /// Theme.of(context).cardColor is used.
  final Color? color;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// If provided, the size of the [Icon].
  ///
  /// If this property is null, then [IconThemeData.size] is used.
  /// If [IconThemeData.size] is also null, then
  /// default size is 24.0 pixels.
  final double? iconSize;

  /// Optional size constraints for the menu.
  ///
  /// When unspecified, defaults to:
  /// ```dart
  /// const BoxConstraints(
  ///   minWidth: 2.0 * 56.0,
  ///   maxWidth: 5.0 * 56.0,
  /// )
  /// ```
  ///
  /// The default constraints ensure that the menu width matches maximum width
  /// recommended by the material design guidelines.
  /// Specifying this parameter enables creation of menu wider than
  /// the default maximum width.
  final BoxConstraints? constraints;

  /// Whether the popup menu is positioned over or under the popup menu button.
  ///
  /// [offset] is used to change the position of the popup menu relative to the
  /// position set by this parameter.
  ///
  /// When not set, the position defaults to [PopupMenuPosition.over] which makes the
  /// popup menu appear directly over the button that was used to create it.
  final PopupMenuPosition position;

  @override
  Widget build(BuildContext context) {
    final items = (builder ?? () => _items!).call();
    assert(items.isNotEmpty);

    return PopupMenuButton(
      itemBuilder: (context) => items
          .map(
            (e) => PopupMenuItem<V>(
              child: PopupMenuItemListTile(icon: e.icon, label: e.label),
              value: e.value,
              enabled: !e.disabled,
            ),
          )
          .toList(),
      onSelected: (key) => items.firstWhere((element) => element.value == key).onSelect?.call(),
      initialValue: initialValue,
      onCanceled: onCanceled,
      tooltip: tooltip,
      elevation: elevation,
      padding: padding,
      child: child,
      splashRadius: splashRadius,
      icon: icon,
      iconSize: iconSize,
      offset: offset,
      enabled: enabled,
      shape: shape,
      color: color,
      enableFeedback: enableFeedback,
      constraints: constraints,
      position: position,
    );
  }
}

class MenuEntry<V> {
  final Widget label;
  final Widget? icon;
  final V value;
  final void Function()? onSelect;
  final bool disabled;

  MenuEntry({
    required this.label,
    this.icon,
    required this.value,
    required this.onSelect,
    this.disabled = false,
  });
}
