import 'package:get/get.dart';

class CharInfoController extends GetxController {
  final displayName = ''.obs;
  final bioDesc = ''.obs;
  final avatarUrl = ''.obs;

  bool get isValid => isCharInfoValid(
        displayName: displayName.value,
        bioDesc: bioDesc.value,
        avatarUrl: avatarUrl.value,
      );

  void updateCharInfo({
    required String displayName,
    required String bioDesc,
    required String avatarUrl,
  }) {
    this.displayName.value = displayName;
    this.bioDesc.value = bioDesc;
    this.avatarUrl.value = avatarUrl;
  }

  static bool isCharInfoValid({
    required String displayName,
    required String bioDesc,
    required String avatarUrl,
  }) {
    return displayName.isNotEmpty;
  }
}
