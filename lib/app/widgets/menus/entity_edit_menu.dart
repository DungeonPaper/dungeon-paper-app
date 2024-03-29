import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class EntityEditMenu extends StatelessWidget {
  const EntityEditMenu({
    super.key,
    required this.onEdit,
    required this.onDelete,
    this.leading = const [],
    this.trailing = const [],
  });

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
              label: Text(tr.generic.edit),
              onSelect: onEdit!,
            ),
          if (onDelete != null)
            MenuEntry(
              value: 'remove',
              icon: IconTheme(
                data: IconThemeData(color: Theme.of(context).colorScheme.error),
                child: const Icon(Icons.delete),
              ),
              label: DefaultTextStyle.merge(
                style: TextStyle(color: Theme.of(context).colorScheme.error),
                child: Text(tr.generic.remove),
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
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.more_vert),
        ),
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
