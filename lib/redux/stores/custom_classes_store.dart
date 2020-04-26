import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_world_data/player_class.dart';

class CustomClassesStore {
  Map<String, PlayerClass> customClasses;

  CustomClassesStore({
    this.customClasses,
  });
}

CustomClassesStore customClassesReducer(CustomClassesStore state, action) {
  if (action is SetCustomClasses) {
    state.customClasses = action.classes;
    return state;
  }

  return state;
}
