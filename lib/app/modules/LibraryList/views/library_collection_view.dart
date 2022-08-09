import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/library_collection_controller.dart';

class LibraryCollectionView extends GetView<LibraryCollectionController>
    with RepositoryServiceMixin, UserServiceMixin, CharacterServiceMixin {
  static const List<Type> types = [Move, Spell, Item, CharacterClass, Race];

  const LibraryCollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.libraryCollectionTitle),
        centerTitle: true,
        actions: [
          MenuButton(
            items: [
              MenuEntry(
                label: Text(S.current.reloadLibrary),
                icon: const Icon(Icons.refresh),
                disabled: repo.my.isLoading || repo.builtIn.isLoading,
                value: 'refresh',
                onSelect: () {
                  userService.loadBuiltInRepo(ignoreCache: true);
                  userService.loadMyRepo(ignoreCache: true);
                },
              ),
            ],
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: types.length,
        itemBuilder: (context, index) {
          return Obx(
            () {
              final type = types[index];
              return Card(
                child: ListTile(
                  onTap: () => ModelPages.openLibraryList(
                    type: type,
                    abilityScores: maybeChar?.abilityScores ?? AbilityScores.dungeonWorldAll(10),
                    classKeys: [],
                    moveCategory: null,
                    // initialTab: charService.maybeCurrent != null
                    //     ? repo.my.classes.keys.contains(character.characterClass.key)
                    //         ? FiltersGroup.my
                    //         : FiltersGroup.playbook
                    //     : null,
                  ),
                  horizontalTitleGap: 8,
                  leading: Container(
                    constraints: const BoxConstraints(maxWidth: 32),
                    height: double.infinity,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Meta.genericIconFor(type), size: 32),
                    ),
                  ),
                  title: Text(
                    S.current.entityPlural(type),
                    style: textTheme.headline6,
                  ),
                  subtitle: Text(
                    [
                      S.current.libraryCollectionListItemSubtitle(
                        NumberFormat('#,###,###').format(repo.builtIn.listByType(type).length),
                        S.current.libraryCollectionListItemSubtitleType('builtIn'),
                      ),
                      S.current.libraryCollectionListItemSubtitle(
                        NumberFormat('#,###,###').format(repo.my.listByType(type).length),
                        S.current.libraryCollectionListItemSubtitleType('my'),
                      ),
                    ].join(' | '),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
