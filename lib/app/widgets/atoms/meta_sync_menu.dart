import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:flutter/material.dart';

// TODO remove this class and use EntityShareMenu instead
class MetaSyncMenu<T, M> extends StatelessWidget {
  const MetaSyncMenu({
    Key? key,
    required this.entity,
  }) : super(key: key);

  final WithMeta<T, dynamic> entity;

  @override
  Widget build(BuildContext context) {
    return MenuButton<String>(
      items: items,
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

  Meta<M> get meta => entity.meta as Meta<M>;

  List<MenuEntry<String>> get items => [
        MenuEntry(
          label: Text('Version: ${meta.version}\n'
              'Dirty: ${meta.sharing?.dirty ?? 'false'}\n'
              'isFork: ${meta.isForkOf(entity)}\n'
              'sourceOwner: ${meta.sharing?.sourceOwner}\n'
              'createdBy: ${meta.createdBy}\n'
              'key: ${entity.key}\n'
              'sourceKey: ${meta.sharing?.sourceKey}'),
          disabled: true,
          value: '',
          onSelect: null,
        ),
        MenuEntry(
          label: const Text('Update original'),
          value: 'push',
          onSelect: () => debugPrint('Update original'),
        ),
        MenuEntry(
          label: const Text('Revert changes'),
          value: 'pull',
          onSelect: () => debugPrint('Revert changes'),
        ),
      ];
}
