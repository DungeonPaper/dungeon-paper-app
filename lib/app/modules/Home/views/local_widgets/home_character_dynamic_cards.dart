import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/utils/list_utils.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card_mini.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card_mini.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeCharacterDynamicCards extends GetView<CharacterService> {
  const HomeCharacterDynamicCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cardSize = Size(210, 153);

    return Obx(() {
      final moves = (controller.current?.moves ?? <Move>[]).where((m) => m.favorited);
      final spells = (controller.current?.spells ?? <Spell>[]).where((m) => m.prepared);

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(S.current.dynamicCategoriesMoves),
          ),
          _HorizontalCardListView<Move>(
            cardSize: cardSize,
            items: moves,
            cardBuilder: (move, _) => MoveCardMini(move: move),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(S.current.dynamicCategoriesSpells),
          ),
          _HorizontalCardListView<Spell>(
            cardSize: cardSize,
            items: spells,
            cardBuilder: (spell, _) => SpellCardMini(spell: spell),
          ),
        ],
      );
    });
  }
}

class _HorizontalCardListView<T> extends StatelessWidget {
  const _HorizontalCardListView({
    Key? key,
    required this.cardSize,
    required this.items,
    required this.cardBuilder,
  }) : super(key: key);

  final Size cardSize;
  final Widget Function(T item, int index) cardBuilder;
  final Iterable<T> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardSize.height,
      width: double.infinity,
      // width: 200,
      child: ListView(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // itemExtent: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          for (final item in Enumerated.listFrom(items))
            Padding(
              padding: EdgeInsets.only(right: item.index == items.length - 1 ? 0 : 8),
              child: SizedBox(
                width: cardSize.width,
                child: cardBuilder(item.value, item.index),
              ),
            ),
        ],
      ),
    );
  }
}
