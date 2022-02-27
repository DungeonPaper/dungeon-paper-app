import 'package:get/get.dart';

import '../../../data/models/character_class.dart';

class CharClassSelectController extends GetxController {
  final _selectedClass = Rx<CharacterClass?>(null);
  final _availableClasses = <CharacterClass>[].obs;
  final _validCache = false.obs;
  final _loading = true.obs;

  CharacterClass? get selectedClass => _selectedClass.value;
  List<CharacterClass> get availableClasses => _availableClasses;
  bool get _isValid => selectedClass != null;
  bool get isValid => _validCache.value;
  bool get loading => _loading.value;

  @override
  void onInit() {
    super.onInit();
    getClasses();
  }

  void getClasses() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _availableClasses.value = [
      CharacterClass.empty().copyInheritedWith(name: 'Druid'),
      CharacterClass.empty().copyInheritedWith(name: 'Immolator'),
      CharacterClass.empty().copyInheritedWith(name: 'Fighter'),
    ];
    _loading.value = false;
  }

  void setCharClass(CharacterClass cls) {
    _selectedClass.value = cls;
  }

  bool validate() {
    return _validCache.value = _isValid;
  }
}
