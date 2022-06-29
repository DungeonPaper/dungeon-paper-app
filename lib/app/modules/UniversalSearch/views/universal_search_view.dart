import 'dart:ui';

import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/widgets/atoms/search_field.dart';
import 'package:dungeon_paper/app/widgets/cards/character_class_card.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/universal_search_controller.dart';

class UniversalSearchView extends GetView<UniversalSearchController> {
  const UniversalSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(right: 28),
            child: SearchField(
              controller: controller.search,
              autofocus: true,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: Obx(
          () => ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.flatResults.length,
            itemBuilder: (context, index) => _CardByType(controller.flatResults[index]),
          ),
        ),
      ),
    );
  }
}

class _CardByType extends StatelessWidget {
  const _CardByType(this.result, {super.key});

  final dynamic result;

  @override
  Widget build(BuildContext context) {
    final row = _buildRow();
    switch (row.runtimeType) {
      case Text:
        return _padded(row, const EdgeInsets.symmetric(vertical: 8));
    }
    return _padded(row);
  }

  StatelessWidget _buildRow() {
    switch (result.runtimeType) {
      case Move:
        return MoveCard(move: result, showStar: false);
      case Spell:
        return SpellCard(spell: result, showStar: false);
      case Item:
        return ItemCard(item: result, showStar: false, hideCount: true);
      case CharacterClass:
        return CharacterClassCard(characterClass: result, showStar: false);
      case SearchSeparator:
        return Text(result.text);
      default:
        assert(false, 'Unknown type: ${result.runtimeType}');
        return Container();
    }
  }

  Widget _padded(Widget child, [EdgeInsets? padding]) => Padding(
        padding: padding ?? const EdgeInsets.only(bottom: 8),
        child: child,
      );
}
