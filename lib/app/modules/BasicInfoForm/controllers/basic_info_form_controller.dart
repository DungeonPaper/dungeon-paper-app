import 'dart:io';

import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/core/utils/upload_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicInfoFormController extends GetxController with UserServiceMixin {
  final Rx<TextEditingController> name = TextEditingController().obs;
  final Rx<TextEditingController> avatarUrl = TextEditingController().obs;
  late final void Function(String name, String avatar) onChanged;
  final uploading = false.obs;

  final Rx<File?> photoFile = Rx(null);
  final dirty = false.obs;

  bool get hasPhotoFile => photoFile.value != null;
  bool get isUploading => uploading.value;

  void startUploadFlow(BuildContext context) {
    cropAndUploadPhoto(
      context,
      UploadSettings(
        uploadPath: '/CharacterPhoto/' + uuid(),
        onUploadFile: (_) => uploading.value = true,
        onSuccess: (url) {
          avatarUrl.value.text = url;
          uploading.value = false;
        },
        onCancel: () => uploading.value = false,
        onError: (error) => uploading.value = false,
      ),
    );
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
