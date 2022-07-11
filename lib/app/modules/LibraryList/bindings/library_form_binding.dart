import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/widgets/forms/character_class_form.dart';
import 'package:dungeon_paper/app/widgets/forms/item_form.dart';
import 'package:dungeon_paper/app/widgets/forms/move_form.dart';
import 'package:dungeon_paper/app/widgets/forms/note_form.dart';
import 'package:dungeon_paper/app/widgets/forms/spell_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:get/get.dart';

class RepositoryItemFormBinding<T> extends Bindings {
  RepositoryItemFormBinding();

  @override
  void dependencies() {
    switch (T) {
      case Move:
        Get.put<DynamicFormController<Move>>(MoveFormController());
        break;
      case Spell:
        Get.put<DynamicFormController<Spell>>(SpellFormController());
        break;
      case Item:
        Get.put<DynamicFormController<Item>>(ItemFormController());
        break;
      case Note:
        Get.put<DynamicFormController<Note>>(NoteFormController());
        break;
      case CharacterClass:
        Get.put<DynamicFormController<CharacterClass>>(CharacterClassFormController());
        break;
      default:
        throw UnsupportedError('Type $T is unsupported');
    }
  }
}
