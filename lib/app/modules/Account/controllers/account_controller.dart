import 'package:dungeon_paper/app/data/services/auth_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/core/utils/upload_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class AccountController extends ChangeNotifier
    with UserProviderMixin, AuthProviderMixin {
  var uploading = false;

  void updateEmail(BuildContext context, String email) async {
    final messenger = ScaffoldMessenger.of(context);
    await userProvider.updateEmail(email);
    messenger.showSnackBar(
      SnackBar(content: Text(tr.account.details.email.success)),
    );
  }

  void uploadPhoto(BuildContext context) {
    cropAndUploadPhoto(
      context,
      UploadSettings(
        uploadPath: '/UserPhoto/${uuid()}',
        cropStyle: CropStyle.circle,
        onUploadFile: (_) {
          uploading = true;
          notifyListeners();
        },
        onSuccess: (url) {
          uploading = false;
          userProvider.updateUser(user.copyWith(photoUrl: url));
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
}
