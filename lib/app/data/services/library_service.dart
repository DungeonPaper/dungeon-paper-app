import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/model_utils/model_json.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:get/get.dart';

class LibraryService extends GetxService {
  StorageHandler get storage => StorageHandler.instance;
  CharacterService get chars => Get.find();

  void addToMyLibrary<T extends WithMeta>(Iterable<T> items) async {
    for (final item in items) {
      var storageKey = storageKeyFor<T>();
      storage.create(storageKey, item.key, toJsonFor(item));
    }
  }

  void updateInMyLibrary<T extends WithMeta>(Iterable<T> items) async {
    for (final item in items) {
      var storageKey = storageKeyFor<T>();
      storage.update(storageKey, item.key, toJsonFor(item));
    }
  }

  void addToCharacter<T extends WithMeta>(Iterable<T> items, [Character? char]) async {
    chars.updateCharacter(
      CharacterUtils.addByType<T>(char ?? chars.current!, items),
    );
  }

  void updateOnCharacter<T extends WithMeta>(Iterable<T> items, [Character? char]) async {
    chars.updateCharacter(
      CharacterUtils.updateByType<T>(char ?? chars.current!, items),
    );
  }
}
