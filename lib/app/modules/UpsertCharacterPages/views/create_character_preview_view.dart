import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/create_character_preview_controller.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/app/widgets/atoms/expansion_row.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/race_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/molecules/character_subtitle.dart';
import 'package:dungeon_paper/app/widgets/molecules/roll_stats_grid.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: ListView(
          children: [
            Center(child: CharacterAvatar.squircle(character: char, size: 176)),
            Text(
              char.displayName,
              textScaleFactor: 1.4,
              textAlign: TextAlign.center,
            ),
            Center(child: CharacterSubtitle(character: char)),
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
            const SizedBox(height: 8),
            ExpansionRow(
              title: Text(S.current.movesWithCount(char.moves.length + 1)),
              icon: SvgIcon(Move.genericIcon),
              expansionKey: const PageStorageKey('moves'),
              children: [char.race, ...char.moves]
                  .map((move) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: move is Move
                            ? MoveCard(
                                move: move,
                                showDice: false,
                                showStar: false,
                                initiallyExpanded: false,
                              )
                            : move is Race
                                ? RaceCard(
                                    race: move,
                                    showStar: false,
                                    initiallyExpanded: false,
                                  )
                                : Container(),
                      ))
                  .toList(),
            ),
            ExpansionRow(
              title: Text(S.current.spellsWithCount(char.spells.length)),
              icon: SvgIcon(Spell.genericIcon),
              expansionKey: const PageStorageKey('spells'),
              children: char.spells
                  .map((spell) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SpellCard(
                          spell: spell,
                          showDice: false,
                          showStar: false,
                          initiallyExpanded: false,
                        ),
                      ))
                  .toList(),
            ),
            ExpansionRow(
              title: Text(S.current.itemsWithCount(char.items.length) +
                  ' + ' +
                  S.current.coinsWithCount(char.coins, NumberFormat('##0.#').format(char.coins))),
              icon: SvgIcon(Item.genericIcon),
              expansionKey: const PageStorageKey('items'),
              children: char.items
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ItemCard(
                          item: item,
                          showStar: false,
                          initiallyExpanded: false,
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 72),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AdvancedFloatingActionButton.extended(
        onPressed: () => controller.createChar(),
        label: Text(S.current.createCharacterSaveButton),
        icon: const Icon(Icons.check),
      ),
    );
  }
}
