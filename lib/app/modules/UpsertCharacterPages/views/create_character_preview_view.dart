import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/create_character_preview_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/app/widgets/atoms/expansion_row.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/roll_stats_grid.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CreateCharacterPreviewView extends GetView<CreateCharacterPreviewController> {
  const CreateCharacterPreviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final char = controller.char;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.createCharacterPreviewPageTitle),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Center(child: CharacterAvatar(character: char)),
          Text(
            char.displayName,
            textScaleFactor: 1.4,
            textAlign: TextAlign.center,
          ),
          Text(
            S.current.characterHeaderSubtitle(
              1,
              char.characterClass.name,
              S.current.alignment(char.bio.alignment.key),
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            S.current.createCharacterPreviewPageMaxHp(char.maxHp),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              width: 340,
              child: RollStatsGrid(
                rollStats: char.rollStats.stats,
                showDice: false,
              ),
            ),
          ),
          ExpansionRow(
            title: Text(S.current.movesWithCount(char.moves.length)),
            children: char.moves
                .map((move) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: MoveCard(move: move, showDice: false),
                    ))
                .toList(),
          ),
          ExpansionRow(
            title: Text(S.current.spellsWithCount(char.spells.length)),
            children: char.spells
                .map((spell) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SpellCard(spell: spell, showDice: false),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
