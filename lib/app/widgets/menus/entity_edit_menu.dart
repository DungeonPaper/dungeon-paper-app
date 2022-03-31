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
      child: PopupMenuButton(
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.more_vert),
        ),
        onSelected: (value) => <String, void Function()?>{
          'remove': onDelete,
          'edit': onEdit,
        }[value]
            ?.call(),
        itemBuilder: (context) => [
          if (onEdit != null)
            PopupMenuItem(
              child: Row(
                children: [
                  const SizedBox(
                    width: 40,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.edit),
                    ),
                  ),
                  Text(S.current.edit),
                ],
              ),
              value: 'edit',
            ),
          if (onDelete != null)
            PopupMenuItem(
              child: DefaultTextStyle.merge(
                style: TextStyle(color: Theme.of(context).errorColor),
                child: IconTheme(
                  data: IconThemeData(color: Theme.of(context).errorColor),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 40,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.delete),
                        ),
                      ),
                      Text(S.current.remove),
                    ],
                  ),
                ),
              ),
              value: 'remove',
            ),
        ],
      ),
    );
  }
}
