import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:image_cropper/image_cropper.dart';

class BasicInfoFormController extends GetxController {
  final Rx<TextEditingController> name = TextEditingController().obs;
  final Rx<TextEditingController> avatarUrl = TextEditingController().obs;
  late final void Function(String name, String avatar) onChanged;

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
    final BasicInfoFormArguments args = Get.arguments;
    onChanged = args.onChanged;
    name.value = TextEditingController(text: args.name);
    avatarUrl.value = TextEditingController(text: args.avatarUrl);

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

class BasicInfoFormArguments {
  final String name;
  final String avatarUrl;
  final void Function(String name, String avatar) onChanged;

  BasicInfoFormArguments({
    required this.name,
    required this.avatarUrl,
    required this.onChanged,
  });
}
