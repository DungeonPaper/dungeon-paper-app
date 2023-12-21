import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/core/global_keys.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'character_provider.dart';
import 'user_provider.dart';

class LibraryProvider extends ChangeNotifier
    with CharacterProviderMixin, UserProviderMixin {
  StorageHandler get storage => StorageHandler.instance;

  static LibraryProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<LibraryProvider>(context, listen: listen);

  static Widget consumer(
          Widget Function(
                  BuildContext context, LibraryProvider library, Widget? child)
              builder) =>
      Consumer<LibraryProvider>(builder: builder);

  Future<bool> existsInLibrary<T extends WithMeta>(T item) async {
    final res = await storage.getDocument(item.storageKey, item.key);
    return res != null;
  }

  void upsertToLibrary<T extends WithMeta>(Iterable<T> items) async {
    for (final item in items) {
      var storageKey = item.storageKey;
      if (await existsInLibrary(item)) {
        storage.update(storageKey, item.key, item.toJson());
      } else {
        storage.create(storageKey, item.key, item.toJson());
      }
    }
  }

  void removeFromLibrary<T extends WithMeta>(Iterable<T> items) {
    for (final item in items) {
      var storageKey = item.storageKey;
      storage.delete(storageKey, item.key);
    }
  }

  void upsertToCharacter<T extends WithMeta>(
    Iterable<T> items, {
    Character? char,
    ForkBehavior forkBehavior = ForkBehavior.none,
  }) async {
    if (forkBehavior != ForkBehavior.none) {
      // items = items.map((e) => (e.meta.createdBy == user.username)
      //     ? increaseMetaVersion(e)
      //     : forkMeta(e, user));

      items = items.map(
        (e) {
          debugPrint('forking $e: $forkBehavior');
          return [ForkBehavior.fork, ForkBehavior.both].contains(forkBehavior)
              ? Meta.forkMeta(
                  e,
                  user,
                  version: forkBehavior == ForkBehavior.both ? uuid() : null,
                )
              : Meta.increaseMetaVersion(e);
        },
      );
    }

    var m = items.elementAt(0).meta;
    debugPrint('upserting meta ${m.toJson()}');
    charProvider.updateCharacter(
      CharacterUtils.upsertByType<T>(char ?? charProvider.current, items),
    );
  }

  void removeFromCharacter<T extends WithMeta>(
    BuildContext context,
    Iterable<T> items, [
    Character? char,
  ]) async {
    charProvider.updateCharacter(
      CharacterUtils.removeByType<T>(char ?? charProvider.current, items),
    );
  }
}

enum ForkBehavior {
  fork,
  increaseVersion,
  none,
  both,
}

mixin LibraryProviderMixin {
  LibraryProvider get libraryProvider =>
      LibraryProvider.of(appGlobalKey.currentContext!);
}
