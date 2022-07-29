import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class EntityEditMenu extends StatelessWidget {
  const EntityEditMenu({
    Key? key,
    required this.onEdit,
    required this.onDelete,
    this.leading = const [],
    this.trailing = const [],
  }) : super(key: key);

  final void Function()? onEdit;
  final void Function()? onDelete;
  final List<PopupMenuItem> leading;
  final List<PopupMenuItem> trailing;

  @override
  Widget build(BuildContext context) {
    if (onEdit == null && onDelete == null) {
      return const EntityEditMenuBlank();
    }

    return Material(
      type: MaterialType.transparency,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: MenuButton(
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.more_vert),
        ),
        items: <PopupMenuEntry>[
          ...leading,
          if (leading.isNotEmpty)
            const PopupMenuDivider(
                // thickness: 1,
                // indent: 16,
                // endIndent: 16,
                ),
          if (onEdit != null)
            MenuEntry(
              value: 'edit',
              icon: const Icon(Icons.edit),
              label: Text(S.current.edit),
              onSelect: onEdit!,
            ),
          if (onDelete != null)
            MenuEntry(
              value: 'remove',
              icon: IconTheme(
                data: IconThemeData(color: Theme.of(context).errorColor),
                child: const Icon(Icons.delete),
              ),
              label: DefaultTextStyle.merge(
                style: TextStyle(color: Theme.of(context).errorColor),
                child: Text(S.current.remove),
              ),
              onSelect: onDelete!,
            ),
          if (trailing.isNotEmpty)
            const PopupMenuDivider(
                // thickness: 1,
                // indent: 16,
                // endIndent: 16,
                ),
          ...trailing,
        ],
      ),
    );
  }
}

class EntityEditMenuBlank extends StatelessWidget {
  const EntityEditMenuBlank({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
