import 'package:dungeon_paper/app/data/services/auth_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/model_utils/user_utils.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_snack_bar.dart';
import 'package:dungeon_paper/core/utils/upload_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class AccountController extends ChangeNotifier
    with UserProviderMixin, AuthProviderMixin {
  var uploading = false;

  void updateEmail(BuildContext context, String email) async {
    await userProvider.updateEmail(email);
    notifyListeners();
    CustomSnackBar.show(
      content: tr.account.details.email.success,
    );
  }

  void updateDisplayName(BuildContext context, String displayName) async {
    await userProvider.updateUser(user.copyWith(displayName: displayName));
    notifyListeners();
    CustomSnackBar.show(
      content: tr.account.details.displayName.success,
    );
  }

  void updatePassword(BuildContext context, String password) async {
    await authProvider.fbUser!.updatePassword(password);
    notifyListeners();
    CustomSnackBar.show(
      content: tr.account.details.password.success,
    );
  }

  void unlinkProvider(BuildContext context, ProviderName providerId) async {
    authProvider.logoutFromProvider(providerId);
    authProvider.fbUser!.unlink(domainFromProviderName(providerId));
    notifyListeners();
    CustomSnackBar.show(
      content: tr.account.unlink.success(
        tr.auth.providers.name(providerId.name),
      ),
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
        onSuccess: (url) async {
          await userProvider.updateUser(user.copyWith(photoUrl: url));
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
}

