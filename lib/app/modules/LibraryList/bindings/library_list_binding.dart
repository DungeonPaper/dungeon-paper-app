import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/race_filters.dart';
import 'package:get/get.dart';

import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';

import '../views/filters/character_class_filters.dart';
import '../views/filters/item_filters.dart';
import '../views/filters/move_filters.dart';
import '../views/filters/spell_filters.dart';

class LibraryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LibraryListController<Move, MoveFilters>>(
      () => LibraryListController<Move, MoveFilters>(),
    );
    Get.lazyPut<LibraryListController<Spell, SpellFilters>>(
      () => LibraryListController<Spell, SpellFilters>(),
    );
    Get.lazyPut<LibraryListController<Item, ItemFilters>>(
      () => LibraryListController<Item, ItemFilters>(),
    );
    Get.lazyPut<LibraryListController<CharacterClass, CharacterClassFilters>>(
      () => LibraryListController<CharacterClass, CharacterClassFilters>(),
    );
    Get.lazyPut<LibraryListController<Race, RaceFilters>>(
      () => LibraryListController<Race, RaceFilters>(),
    );
  }
}
