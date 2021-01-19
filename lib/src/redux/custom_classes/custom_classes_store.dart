import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/redux/users/user_controller.dart';
import 'package:get/get.dart';
part 'custom_class_actions.dart';

class CustomClassesController extends GetxController {
  final RxMap<String, CustomClass> classes = {}.obs;

  void upsert(CustomClass cls) {
    classes[cls.documentID] = cls;
    update();
  }

  void remove(CustomClass cls) {
    classes.remove(cls.documentID);
    update();
  }

  void setAll(Iterable<CustomClass> classes) {
    clear(false);
    this.classes.assignAll({
      for (final cls in classes) cls.documentID: cls,
    });
    update();
  }

  void clear([bool updateCondition = true]) {
    classes.removeWhere((_, __) => true);
    update(null, updateCondition);
  }
}

final customClassesController = CustomClassesController();

CustomClassesController customClassesReducer(
    CustomClassesController state, action) {
  if (action is SetCustomClasses) {
    state.setAll(action.classes.values);
    return state;
  }

  if (action is UpsertCustomClass) {
    state.upsert(action.customClass);
    return state;
  }

  if (action is RemoveCustomClass) {
    state.remove(action.customClass);
    return state;
  }

  if (action is Logout) {
    state.clear();
    return state;
  }

  return state;
}
