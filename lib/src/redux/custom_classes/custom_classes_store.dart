import 'package:dungeon_paper/db/models/custom_class.dart';
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
      action.customClass.docID: action.customClass,
    });
    return state;
  }

  return state;
}
