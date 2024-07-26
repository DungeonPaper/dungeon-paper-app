import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/select_moves_spells_controller.dart';

class SelectMovesSpellsView extends StatelessWidget {
  const SelectMovesSpellsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context).textTheme.titleLarge;
    return Consumer<SelectMovesSpellsController>(
      builder: (context, controller, _) => ConfirmExitView(
        dirty: controller.dirty,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              tr.generic.selectEntity(tr.createCharacter.movesSpells.title),
            ),
            centerTitle: true,
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: () => _save(context),
            label: Text(tr.generic.save),
            icon: const Icon(Icons.save),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // MOVES TITLE
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                      tr.entityCountNum(
                        tn(Move),
                        controller.moves.length,
                      ),
                      style: titleStyle),
                ),
                // MOVES CARDS
                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  physics: const NeverScrollableScrollPhysics(),
                  children: controller.sortedMoves
                      .map((move) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: MoveCard(
                              move: move,
                              showDice: false,
                              showStar: false,
                              actions: [
                                EntityEditMenu(
                                  onEdit: () => ModelPages.openMovePage(
                                    context,
                                    abilityScores: controller.abilityScores,
                                    move: move,
                                    onSave: controller.updateMove,
                                  ),
                                  onDelete: () => controller.deleteMove(move),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                // ADD MOVES
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      style: ButtonThemes.primaryOutlined(context),
                      onPressed: () => ModelPages.openMovesList(
                        context,
                        character: Character.empty().copyWith(
                          characterClass: controller.characterClass,
                        ),
                        preSelections: controller.moves,
                        category: MoveCategory.advanced1,
                        onSelected: (moves) {
                          controller.addMoves(
                            moves.map(
                              (m) => m.copyWithInherited(favorite: true),
                            ),
                          );
                        },
                      ),
                      label:
                          Text(tr.generic.addEntity(tr.entityPlural(tn(Move)))),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ),
                // SPELLS TITLE
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                          .copyWith(top: 24),
                  child: Text(
                      tr.entityCount(
                        tn(Spell),
                        controller.spells.length,
                      ),
                      style: titleStyle),
                ),
                // SPELL CARDS
                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  physics: const NeverScrollableScrollPhysics(),
                  children: controller.spells
                      .map((spell) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: SpellCard(
                              spell: spell,
                              showDice: false,
                              showStar: false,
                              actions: [
                                ElevatedButton.icon(
                                  style: ButtonThemes.primaryElevated(context),
                                  onPressed: () {
                                    controller.deleteSpell(spell);
                                  },
                                  label: Text(tr.generic.remove),
                                  icon: const Icon(Icons.remove),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                ),
                // ADD SPELLS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      style: ButtonThemes.primaryOutlined(context),
                      onPressed: () => ModelPages.openSpellsList(
                        context,
                        character: Character.empty().copyWith(
                          characterClass: controller.characterClass,
                        ),
                        list: controller.spells,
                        onSelected: (spells) {
                          controller.addSpells(
                            spells.map(
                              (m) => m.copyWithInherited(prepared: true),
                            ),
                          );
                        },
                      ),
                      label: Text(
                        tr.generic.addEntity(tr.entityPlural(tn(Spell))),
                      ),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _save(BuildContext context) {
    final controller = Provider.of<SelectMovesSpellsController>(
      context,
      listen: false,
    );
    controller.onChanged(controller.moves, controller.spells);
    Navigator.of(context).pop();
  }
}
