import 'dart:async';

import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/xp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/xp_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/hp_dialog.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeCharacterHpExpView extends GetView<CharacterService> {
  const HomeCharacterHpExpView({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: InkWell(
          splashColor: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(10),
          onTap: () => Get.dialog(const HPDialog()),
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: HpBar(),
          ),
        ),
      ),
      const SizedBox(width: 16),
      const Expanded(
        child: _EXP(),
      ),
    ],
  );
}

class _EXP extends StatefulWidget {
  const _EXP();

  @override
  State<_EXP> createState() => _EXPState();
}

class _EXPState extends State<_EXP> with CharacterServiceMixin {
  var _hidden = true;

  Timer _timer = Timer(Duration.zero, () {});
  
  void showButtons({bool shown = true}) {
    setState(() {_hidden = !shown;});
    _timer.cancel();
    if (!shown) return;
    _timer = Timer(const Duration(seconds: 2), () {
      setState(() {_hidden = true;});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          splashColor: Theme.of(context).splashColor,
          borderRadius: BorderRadius.circular(10),
          onTap: showButtons,
          child: const Padding(
            padding: EdgeInsets.all(4),
            child: ExpBar()
          ),
        ),
        IgnorePointer(
          ignoring: _hidden,
          child: AnimatedOpacity(
            opacity: _hidden ? 0 : 1,
            duration: const Duration(milliseconds: 200),
            child: Row(
              children: [
                const SizedBox(width: 16),
                PrimaryChip(
                  label: '+1',
                  onPressed: () {
                    showButtons(shown: false);
                    charService.updateCharacter(
                      char.copyWith(
                        stats: char.stats.copyWith(
                          currentXp: 1 + (char.stats.currentXp),
                        ),
                      ),
                    );
                  },
                ),
                const Expanded(child: SizedBox(width: 0)),
                PrimaryChip(
                  label: '',
                  icon: const Icon(DwIcons.scroll_quill),
                  onPressed: () {
                    showButtons(shown: false);
                    Get.dialog(const EXPDialog());
                  },
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
