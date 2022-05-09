import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MetaSyncMenu<T> extends StatelessWidget {
  const MetaSyncMenu({
    Key? key,
    required this.entity,
  }) : super(key: key);

  final WithMeta<T> entity;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (ctx) => items,
      onSelected: (value) => _handleMenu(value),
      icon: Stack(children: [
        const Icon(Icons.more_vert),
        if (entity.meta.sharing?.dirty == true)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange[400],
              ),
            ),
          ),
      ]),
    );
  }

  Meta<T> get meta => entity.meta;

  List<PopupMenuItem<String>> get items => [
        PopupMenuItem(
          // TODO intl
          child: Text('Version: ${meta.schemaVersion}\n'
              'Dirty: ${meta.sharing?.dirty ?? 'false'}\n'
              'isFork: ${meta.sharing?.isFork}\n'
              'sourceOwner: ${meta.sharing?.sourceOwner}\n'
              'createdBy: ${meta.createdBy}'),
          enabled: false,
        ),
        PopupMenuItem(
          // TODO intl
          child: Text('Update original'),
          value: 'push',
        ),
        PopupMenuItem(
          // TODO intl
          child: Text('Revert changes'),
          value: 'pull',
        ),
      ];

  _handleMenu(String? value) {
    final curItem = entity;

    switch (value) {
      case 'push':
        debugPrint('Update original');
        break;
      case 'pull':
        debugPrint('Revert changes');
        break;
      default:
        return;
      // throw UnsupportedError('Bad menu item value: $value');
    }
  }
}
