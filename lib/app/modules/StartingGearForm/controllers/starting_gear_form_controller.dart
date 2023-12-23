import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/core/route_arguments.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/widgets.dart';

class StartingGearFormController extends ChangeNotifier {
  final availableGear = <GearChoice>[];
  var dirty = false;

  late List<GearSelection> selectedOptions;
  late CharacterClass characterClass;
  late void Function(List<GearSelection> selectedOptions) onChanged;

  StartingGearFormController(BuildContext context) {
    final StartingGearFormArguments args = getArgs(context);
    selectedOptions = args.selectedOptions.toList();
    characterClass = args.characterClass;
    onChanged = args.onChanged;
    getGear();
  }

  void onChangeClass(cls) {
    selectedOptions.clear();
    getGear();
  }

  void getGear() async {
    availableGear.clear();
    availableGear.addAll(characterClass.gearChoices);
    notifyListeners();
  }

  void toggleSelect(GearSelection selection) {
    dirty = true;
    final found =
        selectedOptions.firstWhereOrNull((item) => item.key == selection.key);
    if (found == null) {
      selectedOptions.add(selection);
    } else {
      selectedOptions.remove(found);
    }
    notifyListeners();
  }

  bool isSelected(GearSelection selection) =>
      selectedOptions.firstWhereOrNull((item) => item.key == selection.key) !=
      null;

  int selectionCount(GearChoice choice) =>
      choice.selections.where((item) => isSelected(item)).length;
}

class StartingGearFormArguments {
  final List<GearSelection> selectedOptions;
  final CharacterClass characterClass;
  final void Function(List<GearSelection> selectedOptions) onChanged;

  StartingGearFormArguments({
    required this.selectedOptions,
    required this.characterClass,
    required this.onChanged,
  });
}
