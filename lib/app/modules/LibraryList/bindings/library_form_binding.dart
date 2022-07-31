import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/widgets/forms/character_class_form.dart';
import 'package:dungeon_paper/app/widgets/forms/item_form.dart';
import 'package:dungeon_paper/app/widgets/forms/move_form.dart';
import 'package:dungeon_paper/app/widgets/forms/note_form.dart';
import 'package:dungeon_paper/app/widgets/forms/race_form.dart';
import 'package:dungeon_paper/app/widgets/forms/spell_form.dart';
import 'package:get/get.dart';

class LibraryFormBinding<T> extends Bindings {
  LibraryFormBinding();

  @override
  void dependencies() {
    switch (T) {
      case Move:
        Get.put<MoveFormController>(MoveFormController());
        break;
      case Spell:
        Get.put<SpellFormController>(SpellFormController());
        break;
      case Item:
        Get.put<ItemFormController>(ItemFormController());
        break;
      case Note:
        Get.put<NoteFormController>(NoteFormController());
        break;
      case CharacterClass:
        Get.put<CharacterClassFormController>(CharacterClassFormController());
        break;
      case Race:
        Get.put<RaceFormController>(RaceFormController());
        break;
      default:
        throw UnsupportedError('Type $T is unsupported');
    }
  }
}
