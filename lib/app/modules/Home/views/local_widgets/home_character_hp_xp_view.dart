import 'package:dungeon_paper/app/widgets/atoms/xp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:dungeon_paper/app/widgets/dialogs/xp_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/hp_dialog.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class HomeCharacterHpExpView extends StatelessWidget {
  const HomeCharacterHpExpView({super.key});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: InkWell(
              splashColor: Theme.of(context).splashColor,
              borderRadius: BorderRadius.circular(10),
              onTap: () => showDialog(
                context: context,
                builder: (_) => const HPDialog(),
              ),
              child: Tooltip(
                message: tr.hp.bar.tooltip(PlatformHelper.actionString(context)),
                preferBelow: false,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: HpBar(),
                ),
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
                builder: (_) => const EXPDialog(),
              ),
              child: Tooltip(
                message: tr.xp.bar.tooltip(PlatformHelper.actionString(context)),
                preferBelow: false,
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: ExpBar(showPlusOneButton: true),
                ),
              ),
            ),
          ),
        ],
      );
}

