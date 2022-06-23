import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class EntityEditMenu extends StatelessWidget {
  const EntityEditMenu({
    Key? key,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  final void Function()? onEdit;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    if (onEdit == null && onDelete == null) {
      return Container();
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
        items: [
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
        ],
      ),
    );
  }
}
