import 'dart:io';

import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;

class BasicInfoFormController extends GetxController with UserServiceMixin {
  final Rx<TextEditingController> name = TextEditingController().obs;
  final Rx<TextEditingController> avatarUrl = TextEditingController().obs;
  late final void Function(String name, String avatar) onChanged;
  final uploading = false.obs;

  final Rx<File?> photoFile = Rx(null);
  final dirty = false.obs;

  bool get hasPhotoFile => photoFile.value != null;
  bool get isUploading => uploading.value;

  void startUploadFlow() async {
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

    uploading.value = true;
    try {
      final cropped = await ImageCropper()
          .cropImage(sourcePath: res, aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));

      final file = File(cropped?.path ?? res);
      photoFile.value = file;

      avatarUrl.value.text = await _uploadPhoto(file);
    } catch (e) {
      Get.rawSnackbar(
          message:
              'Error while uploading photo. Try again later, or contact support using the "About" page.');
    } finally {
      uploading.value = false;
    }
  }

  void resetPhoto() {
    photoFile.value = null;
    avatarUrl.value.text = '';
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

  Future<String> _uploadPhoto(File file) async {
    assert(userService.current.isLoggedIn);
    final ext = path.extension(file.path);
    final ref = FirebaseStorage.instance
        .ref(userService.current.fileStoragePath! + '/CharacterPhoto/' + uuid() + ext);

    await ref.putFile(file);
    return ref.getDownloadURL();
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
