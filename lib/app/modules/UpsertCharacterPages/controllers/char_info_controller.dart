import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CharInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final displayName = TextEditingController().obs;
  final avatarUrl = TextEditingController().obs;
  final _validCache = false.obs;
  bool get _isValid => formKey.currentState?.validate() ?? false;
  bool get isValid => _validCache.value;

  CharInfo get charInfo => CharInfo(
        displayName: displayName.value.text,
        avatarUrl: avatarUrl.value.text,
      );

  void setCharInfo(CharInfo info) {
    displayName.value.text = info.displayName;
    avatarUrl.value.text = info.avatarUrl;
    validate();
  }

  static bool isCharInfoValid(CharInfo info) => info.isValid;

  bool validate() {
    return _validCache.value = _isValid;
  }
}

class CharInfo {
  final String displayName;
  final String avatarUrl;

  CharInfo({
    required this.displayName,
    required this.avatarUrl,
  });

  bool get isValid => displayName.isNotEmpty;
}
