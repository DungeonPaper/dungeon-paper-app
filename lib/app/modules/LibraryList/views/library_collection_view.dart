import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LibraryCollectionView extends StatelessWidget
    with UserProviderMixin, CharacterProviderMixin {
  static const List<Type> types = [Move, Spell, Item, CharacterClass, Race];

  const LibraryCollectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.myLibrary.title),
        centerTitle: true,
        actions: [
          MenuButton(
            items: [
              MenuEntry(
                label: Text(tr.myLibrary.reload),
                icon: const Icon(Icons.refresh),
                // disabled: repo.my.isLoading || repo.builtIn.isLoading,
                value: 'refresh',
                onSelect: () {
                  userProvider.loadBuiltInRepo(ignoreCache: true);
                  userProvider.loadMyRepo(ignoreCache: true);
                },
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 800,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: types.length,
            itemBuilder: (context, index) {
              return RepositoryProvider.consumer(
                (context, repo, _) {
                  final type = types[index];
                  return Card(
                    child: ListTile(
                      onTap: () => ModelPages.openLibraryList(
                        context,
                        type: type,
                        abilityScores: maybeChar?.abilityScores ??
                            AbilityScores.dungeonWorldAll(10),
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
                        tr.entityPlural(tn(type)),
                        style: textTheme.titleLarge,
                      ),
                      subtitle: Text(
                        [
                          tr.myLibrary.itemCount(
                            NumberFormat('#,###,###')
                                .format(repo.builtIn.listByType(type).length),
                            tr.myLibrary.libraryType('builtIn'),
                          ),
                          tr.myLibrary.itemCount(
                            NumberFormat('#,###,###')
                                .format(repo.my.listByType(type).length),
                            tr.myLibrary.libraryType('my'),
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
        ),
      ),
    );
  }
}
