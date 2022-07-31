import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/widgets/forms/character_class_form.dart';
import 'package:dungeon_paper/app/widgets/forms/item_form.dart';
import 'package:dungeon_paper/app/widgets/forms/item_form_new.dart';
import 'package:dungeon_paper/app/widgets/forms/library_entity_form.dart';
import 'package:dungeon_paper/app/widgets/forms/move_form.dart';
import 'package:dungeon_paper/app/widgets/forms/note_form.dart';
import 'package:dungeon_paper/app/widgets/forms/race_form.dart';
import 'package:dungeon_paper/app/widgets/forms/spell_form.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/dynamic_form.dart';
import 'package:get/get.dart';

class LibraryFormBinding<T> extends Bindings {
  LibraryFormBinding();

  @override
  void dependencies() {
    switch (T) {
      case Move:
        // TODO deprecate
        Get.put<DynamicFormController<Move>>(MoveFormController());
        // TODO implement
        // Get.put<LibraryEntityFormController<Move, MoveFormArguments>>(MoveFormController());
        break;
      case Spell:
        // TODO deprecate
        Get.put<DynamicFormController<Spell>>(SpellFormController());
        // TODO implement
        // Get.put<LibraryEntityFormController<Spell, SpellFormArguments>>(SpellFormController());
        break;
      case Item:
        // TODO deprecate
        // Get.put<DynamicFormController<Item>>(ItemFormController());
        // Get.put<LibraryEntityFormController<Item, ItemFormArgumentsNew>>(ItemFormControllerNew());
        Get.put<ItemFormControllerNew>(ItemFormControllerNew());
        break;
      case Note:
        // TODO deprecate
        Get.put<DynamicFormController<Note>>(NoteFormController());
        // TODO implement
        // Get.put<LibraryEntityFormController<Note, NoteFormArguments>>(NoteFormController());
        break;
      case CharacterClass:
        // TODO deprecate
        Get.put<DynamicFormController<CharacterClass>>(CharacterClassFormController());
        // TODO implement
        // Get.put<LibraryEntityFormController<CharacterClass, CharacterClassFormArguments>>(CharacterClassFormController());
        break;
      case Race:
        // TODO deprecate
        Get.put<DynamicFormController<Race>>(RaceFormController());
        // TODO implement
        // Get.put<LibraryEntityFormController<Race, RaceFormArguments>>(RaceFormController());
        break;
      default:
        throw UnsupportedError('Type $T is unsupported');
    }
  }
}
