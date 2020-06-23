import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/redux/users/user_store.dart';
part 'custom_class_actions.dart';

class CustomClassesStore {
  Map<String, CustomClass> customClasses;

  CustomClassesStore({
    this.customClasses,
  });
}

CustomClassesStore customClassesReducer(CustomClassesStore state, action) {
  if (action is SetCustomClasses) {
    state.customClasses = action.classes;
    return state;
  }

  if (action is UpsertCustomClass) {
    state.customClasses.addAll({
      action.customClass.documentID: action.customClass,
    });
    return state;
  }

  if (action is RemoveCustomClass) {
    state.customClasses.remove(action.customClass.documentID);
    return state;
  }

  if (action is Logout) {
    state.customClasses = {};
    return state;
  }

  return state;
}
