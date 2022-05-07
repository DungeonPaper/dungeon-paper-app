import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:image_cropper/image_cropper.dart';

class BasicInfoFormController extends GetxController {
  BasicInfoFormController({
    String name = '',
    String avatarUrl = '',
  })  : name = TextEditingController(text: name).obs,
        avatarUrl = TextEditingController(text: avatarUrl).obs;

  final Rx<TextEditingController> name;
  final Rx<TextEditingController> avatarUrl;
  final Rx<File?> photoFile = Rx(null);
  final dirty = false.obs;

  bool get hasPhotoFile => photoFile.value != null;

  void pickPhoto() async {
    final res = await FlutterFileDialog.pickFile(
      params: const OpenFileDialogParams(
          dialogType: OpenFileDialogType.image,
          fileExtensionsFilter: ['png', 'jpg', 'jpeg', 'gif'],
          mimeTypesFilter: ['image/*']),
    );

    if (res == null) {
      Get.rawSnackbar(message: 'Canceled');
      return;
    }

    final cropped = await ImageCropper()
        .cropImage(sourcePath: res, aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));

    final file = File(cropped?.path ?? res);

    avatarUrl.value.text = file.path;
  }

  @override
  void onReady() {
    super.onReady();
    name.value.addListener(_refreshName);
    avatarUrl.value.addListener(_refreshAvatarUrl);
  }

  @override
  void onClose() {
    name.value.removeListener(_refreshName);
    avatarUrl.value.removeListener(_refreshAvatarUrl);
    super.onClose();
  }

  void _refreshName() {
    name.refresh();
    _setDirty();
  }

  void _refreshAvatarUrl() {
    avatarUrl.refresh();
    _setDirty();
  }

  void _setDirty() {
    dirty.value = true;
  }
}
