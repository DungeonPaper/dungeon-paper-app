import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/xp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:dungeon_paper/app/widgets/dialogs/xp_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/hp_dialog.dart';
import 'package:flutter/material.dart';

class HomeCharacterHpExpView extends StatelessWidget {
  const HomeCharacterHpExpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            splashColor: Theme.of(context).splashColor,
            borderRadius: BorderRadius.circular(10),
            onTap: () => showDialog(
              context: context,
              builder: (context) => const HPDialog(),
            ),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: HpBar(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            splashColor: Theme.of(context).splashColor,
            borderRadius: BorderRadius.circular(10),
            onTap: () => showDialog(
              context: context,
              builder: (context) => const EXPDialog(),
            ),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: ExpBar(),
            ),
          ),
        ),
      ],
    );
  }
}

