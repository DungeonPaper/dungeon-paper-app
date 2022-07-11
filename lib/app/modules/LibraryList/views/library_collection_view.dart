import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/library_collection_controller.dart';

class LibraryCollectionView extends GetView<LibraryCollectionController>
    with RepositoryServiceMixin {
  static const List<Type> types = [Move, Spell, Item, CharacterClass];

  const LibraryCollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.libraryCollectionTitle),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: types.length,
        itemBuilder: (context, index) {
          final type = types[index];

          return Card(
            child: ListTile(
              onTap: ModelPages.openLibraryList(type: type),
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
                S.current.libraryCollectionListItemSubtitle(
                  repo.my.listByType(type).length,
                  S.current.entityPlural(type),
                ),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
