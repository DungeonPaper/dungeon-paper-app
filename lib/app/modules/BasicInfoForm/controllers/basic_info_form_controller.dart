import 'dart:io';

import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/core/route_arguments.dart';
import 'package:dungeon_paper/core/utils/upload_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:flutter/material.dart';

class BasicInfoFormController extends ChangeNotifier with UserProviderMixin {
  final TextEditingController name = TextEditingController();
  final TextEditingController avatarUrl = TextEditingController();
  late final void Function(String name, String avatar) onChanged;
  var uploading = false;
  File? photoFile;
  var dirty = false;

  bool get hasPhotoFile => photoFile != null;
  bool get isUploading => uploading;

  void startUploadFlow(BuildContext context) {
    cropAndUploadPhoto(
      context,
      UploadSettings(
        uploadPath: '/CharacterPhoto/${uuid()}',
        onUploadFile: (_) {
          uploading = true;
          notifyListeners();
        },
        onSuccess: (url) {
          avatarUrl.text = url;
          uploading = false;
          notifyListeners();
        },
        onCancel: () {
          uploading = false;
          notifyListeners();
        },
        onError: (error) {
          uploading = false;
          notifyListeners();
        },
      ),
    );
  }

  void resetPhoto() {
    photoFile = null;
    avatarUrl.text = '';
    notifyListeners();
  }

  BasicInfoFormController(BuildContext context) {
    final BasicInfoFormArguments args = getArgs(context);
    onChanged = args.onChanged;
    name.text = args.name;
    avatarUrl.text = args.avatarUrl;

    name.addListener(_setDirty);
    avatarUrl.addListener(_setDirty);
  }

  @override
  void dispose() {
    super.dispose();
    name.removeListener(_setDirty);
    avatarUrl.removeListener(_setDirty);
  }

  void _setDirty() {
    if (!dirty) {
      dirty = true;
      notifyListeners();
    }
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
