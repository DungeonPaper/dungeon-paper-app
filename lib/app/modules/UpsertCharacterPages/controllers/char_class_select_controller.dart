import 'dart:async';

import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:get/get.dart';

import '../../../data/models/character_class.dart';

class CharClassSelectController extends GetxController {
  final selectedClass = Rx<CharacterClass?>(null);
  final availableClasses = <CharacterClass>[].obs;
  final _validCache = false.obs;
  final loading = true.obs;
  late final StreamSubscription builtInListener;
  late final StreamSubscription myListener;

  bool get _isValid => selectedClass.value != null;
  bool get isValid => _validCache.value;

  @override
  void onInit() {
    super.onInit();

    final ctrl = Get.find<RepositoryService>();
    builtInListener = ctrl.builtIn.classes.listen((map) => getClasses());
    myListener = ctrl.my.classes.listen((map) => getClasses());
    getClasses();
  }

  @override
  void dispose() {
    builtInListener.cancel();
    myListener.cancel();
    super.dispose();
  }

  void updateClasses(Map<String, CharacterClass> classes) {
    availableClasses.clear();
    availableClasses.addAll(classes.values);
  }

  void getClasses() async {
    loading.value = true;
    final ctrl = Get.find<RepositoryService>();
    updateClasses({...ctrl.builtIn.classes, ...ctrl.my.classes});
    loading.value = false;
  }

  void setCharClass(CharacterClass cls) {
    selectedClass.value = cls;
  }

  bool validate() {
    return _validCache.value = _isValid;
  }
}
