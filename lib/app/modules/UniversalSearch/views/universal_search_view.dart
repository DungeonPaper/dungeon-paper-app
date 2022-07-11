import 'dart:ui';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/widgets/atoms/search_field.dart';
import 'package:dungeon_paper/app/widgets/cards/character_class_card.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/universal_search_controller.dart';

class UniversalSearchView extends GetView<UniversalSearchController> {
  UniversalSearchView({Key? key}) : super(key: key);

  final bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          title: SearchField(
            controller: controller.search,
            autofocus: true,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: true,
        ),
        body: Obx(
          () => PageStorage(
            bucket: bucket,
            child: Column(
              children: [
                Obx(
                  () => Wrap(
                    spacing: 8,
                    runSpacing: 0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // TODO intl
                      const Text('Search in: '),
                      if (controller.hasCharacter)
                        _FilterChip(
                          label: S.current.entity(Character),
                          sourceType: SourceType.character,
                        ),
                      _FilterChip(
                        label: S.current.libraryCollectionTitle,
                        sourceType: SourceType.myLibrary,
                      ),
                      _FilterChip(
                        label: S.current.addRepoItemTabPlaybook,
                        sourceType: SourceType.builtInLibrary,
                      ),
                    ],
                  ),
                ),
                FutureBuilder<List<dynamic>>(
                    future: controller.flatResults,
                    builder: (context, value) {
                      if (value.data == null) {
                        return Center(
                          child: SizedBox.fromSize(
                            size: const Size.square(50),
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: value.data!.length,
                          itemBuilder: (context, index) => _CardByType(
                            value.data![index],
                            highlightWords: [controller.search.text.trim()],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardByType extends StatelessWidget {
  const _CardByType(
    this.result, {
    super.key,
    required this.highlightWords,
  });

  final dynamic result;
  final List<String> highlightWords;

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
        return MoveCard(
          move: result,
          showStar: result.favorited,
          highlightWords: highlightWords,
        );
      case Spell:
        return SpellCard(
          spell: result,
          showStar: result.prepared,
          highlightWords: highlightWords,
        );
      case Item:
        return ItemCard(
          item: result,
          showStar: result.equipped,
          hideCount: true,
          highlightWords: highlightWords,
        );
      case CharacterClass:
        return CharacterClassCard(
          characterClass: result,
          showStar: false,
          highlightWords: highlightWords,
        );
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

class _FilterChip extends GetView<UniversalSearchController> {
  const _FilterChip({
    super.key,
    required this.label,
    required this.sourceType,
  });

  final String label;
  final SourceType sourceType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selected = controller.sourceEnabled(sourceType);

    return PrimaryChip(
      icon: selected ? const Icon(Icons.check) : null,
      label: label,
      backgroundColor: selected ? null : theme.disabledColor,
      onPressed: onPressed,
    );
  }

  void onPressed() => controller.toggleSource(sourceType);
}
