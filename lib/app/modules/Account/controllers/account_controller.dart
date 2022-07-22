// TODO remove this line
// ignore_for_file: unnecessary_overrides

import 'package:dungeon_paper/app/data/services/auth_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/core/utils/upload_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class AccountController extends GetxController with UserServiceMixin, AuthServiceMixin {
  final uploading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void uploadPhoto(BuildContext context) {
    cropAndUploadPhoto(
      context,
      UploadSettings(
        uploadPath: '/UserPhoto/' + uuid(),
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
