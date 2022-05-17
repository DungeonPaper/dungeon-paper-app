import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_json.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/app/model_utils/model_meta.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:get/get.dart';

class LibraryService extends GetxService {
  StorageHandler get storage => StorageHandler.instance;
  CharacterService get chars => Get.find();
  User get user => Get.find<UserService>().current;

  Future<bool> existsInLibrary<T extends WithMeta>(T item) async {
    final res = await storage.getDocument(storageKeyFor<T>(), item.key);
    return res != null;
  }

  void upsertToLibrary<T extends WithMeta>(Iterable<T> items) async {
    for (final item in items) {
      var storageKey = storageKeyFor<T>();
      if (await existsInLibrary(item)) {
        storage.update(storageKey, item.key, toJsonFor(item));
      } else {
        storage.create(storageKey, item.key, toJsonFor(item));
      }
    }
  }

  void removeFromLibrary<T extends WithMeta>(Iterable<T> items) {
    for (final item in items) {
      var storageKey = storageKeyFor<T>();
      storage.delete(storageKey, item.key);
    }
  }

  void upsertToCharacter<T extends WithMeta>(
    Iterable<T> items, {
    Character? char,
    bool fork = true,
  }) async {
    if (fork) {
      items = items.map((e) => (e.meta.isFork && e.meta.createdBy == user.username)
          ? increaseMetaVersion(e)
          : forkMeta(e, user));
    }

    chars.updateCharacter(
      CharacterUtils.upsertByType<T>(char ?? chars.current!, items),
    );
  }

  void removeFromCharacter<T extends WithMeta>(Iterable<T> items, [Character? char]) async {
    chars.updateCharacter(
      CharacterUtils.removeByType<T>(char ?? chars.current!, items),
    );
  }
}

mixin LibraryServiceMixin {
  LibraryService get library => Get.find();
}
