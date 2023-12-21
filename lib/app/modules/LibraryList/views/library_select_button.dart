import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

enum LibrarySelectButtonType { button, iconButton }

class LibrarySelectButton<T> extends StatelessWidget {
  const LibrarySelectButton({
    super.key,
    this.type = LibrarySelectButtonType.button,
    required this.selected,
    required this.onPressed,
  });

  const LibrarySelectButton.icon({
    super.key,
    required this.selected,
    required this.onPressed,
  }) : type = LibrarySelectButtonType.iconButton;

  final LibrarySelectButtonType type;
  final bool selected;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    if (onPressed == null) {
      return Tooltip(
        message: tr.myLibrary.selectDisabled(tr.entity(tn(T))),
        child: buildButton(context),
      );
    }
    return buildButton(context);
  }

  Widget buildButton(BuildContext context) {
    const selectedColor = Colors.red;
    const unselectedColor = Colors.green;

    const selectedIcon = Icons.remove;
    const unselectedIcon = Icons.add;
    switch (type) {
      case LibrarySelectButtonType.button:
        return ElevatedButton.icon(
          onPressed: onPressed,
          label: Text(selected ? tr.generic.remove : tr.generic.select),
          icon: Icon(
            selected ? selectedIcon : unselectedIcon,
          ),
          style: ButtonThemes.primaryElevated(context),
        );
      case LibrarySelectButtonType.iconButton:
        return CircleAvatar(
          backgroundColor: onPressed != null
              ? selected
                  ? selectedColor
                  : unselectedColor
              : Colors.grey[800],
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              selected ? selectedIcon : unselectedIcon,
              color: Colors.white,
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
