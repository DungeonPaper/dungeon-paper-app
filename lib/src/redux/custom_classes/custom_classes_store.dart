import 'package:dungeon_world_data/player_class.dart';
part 'custom_class_actions.dart';

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
