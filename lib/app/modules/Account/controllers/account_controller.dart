import 'package:dungeon_paper/app/data/services/auth_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/core/utils/upload_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class AccountController extends GetxController
    with UserServiceMixin, AuthServiceMixin {
  final uploading = false.obs;

  void updateEmail(String email) async {
    await userService.updateEmail(email);
    Get.rawSnackbar(message: tr.account.details.email.success);
  }

  void uploadPhoto(BuildContext context) {
    cropAndUploadPhoto(
      context,
      UploadSettings(
        uploadPath: '/UserPhoto/${uuid()}',
        cropStyle: CropStyle.circle,
        onUploadFile: (_) => uploading.value = true,
        onSuccess: (url) {
          uploading.value = false;
          userService.updateUser(
            user.copyWith(photoUrl: url),
          );
        },
        onCancel: () => uploading.value = false,
        onError: (error) => uploading.value = false,
      ),
    );
  }
}

