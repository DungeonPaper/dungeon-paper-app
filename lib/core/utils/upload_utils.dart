import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_snack_bar.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;

class UploadSettings {
  final void Function(String downloadURL)? onSuccess;
  final void Function(CroppedFile file)? onUploadFile;
  final void Function()? onCancel;
  final void Function(Object error)? onError;
  final CropStyle? cropStyle;

  /// Don't include extension
  final String uploadPath;

  UploadSettings({
    this.onUploadFile,
    this.onSuccess,
    this.onCancel,
    this.onError,
    this.cropStyle,
    required this.uploadPath,
  });
}

class UploadResponse {
  final CroppedFile local;
  final Reference remote;
  final String downloadURL;

  UploadResponse._({
    required this.local,
    required this.remote,
    required this.downloadURL,
  });
}

Future<CroppedFile?> _pickAndCrop(BuildContext context) async {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final settings = [
    AndroidUiSettings(
      backgroundColor: theme.scaffoldBackgroundColor,
      toolbarWidgetColor: colorScheme.secondary,
    ),
    WebUiSettings(context: context),
  ];
  final res = await FlutterFileDialog.pickFile(
    params: const OpenFileDialogParams(
      dialogType: OpenFileDialogType.image,
      fileExtensionsFilter: ['png', 'jpg', 'jpeg', 'gif'],
      mimeTypesFilter: ['image/*'],
    ),
  );
  if (res == null) {
    return null;
  }

  final cropped = await ImageCropper().cropImage(
    sourcePath: res,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    compressQuality: 100,
    compressFormat: ImageCompressFormat.png,
    uiSettings: settings,
  );

  return cropped;
}

Future<Reference> Function(CroppedFile file, String uploadPath)
    _uploadPhotoFactory(BuildContext context) {
  return (file, uploadPath) async {
    final userProvider = UserProvider.of(context);
    assert(userProvider.current.isLoggedIn);

    final ext = path.extension(file.path);
    if (!uploadPath.startsWith('/')) {
      uploadPath = '/$uploadPath';
    }
    final ref = FirebaseStorage.instance
        .ref(userProvider.current.fileStoragePath! + uploadPath + ext);
    await ref.putData(await file.readAsBytes());
    return ref;
  };
}

Future<UploadResponse?> cropAndUploadPhoto(
  BuildContext context,
  UploadSettings settings,
) async {
  CroppedFile? file;
  final uploadPhoto = _uploadPhotoFactory(context);
  try {
    file = await _pickAndCrop(context);
    if (file == null) {
      CustomSnackBar.show(content: tr.errors.userOperationCanceled);
      settings.onCancel?.call();
      return null;
    }
    settings.onUploadFile?.call(file);
  } catch (e) {
    CustomSnackBar.show(content: tr.errors.uploadError);
    settings.onError?.call(e);
    return null;
  }

  Reference fileRef;
  String downloadURL;
  try {
    fileRef = await uploadPhoto(file, settings.uploadPath);
    downloadURL = await fileRef.getDownloadURL();

    settings.onSuccess?.call(downloadURL);
  } catch (e) {
    CustomSnackBar.show(
      content:
          'Error while uploading photo. Try again later, or contact support using the "About" page.',
    );

    settings.onError?.call(e);
    return null;
  }

  return UploadResponse._(
    local: file,
    remote: fileRef,
    downloadURL: downloadURL,
  );
}
