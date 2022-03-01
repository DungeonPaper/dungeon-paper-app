import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CharacterBackgroundController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final bio = TextEditingController().obs;
  final raceName = TextEditingController().obs;
  final raceDesc = TextEditingController().obs;
  final _validCache = false.obs;
  bool get _isValid => formKey.currentState?.validate() ?? false;
  bool get isValid => _validCache.value;

  CharBackground get charBackground => CharBackground(
        bio: bio.value.text,
        raceName: raceName.value.text,
        raceDesc: raceDesc.value.text,
      );

  void setCharBackground(CharBackground info) {
    bio.value.text = info.bio;
    raceName.value.text = info.raceName;
    raceDesc.value.text = info.raceDesc;
    validate();
  }

  static bool isCharBackgroundValid(CharBackground info) => info.isValid;

  bool validate() {
    return _validCache.value = _isValid;
  }
}

class CharBackground {
  final String bio;
  final String raceName;
  final String raceDesc;

  CharBackground({
    required this.bio,
    required this.raceName,
    required this.raceDesc,
  });

  bool get isValid => raceDesc.isNotEmpty;
}
