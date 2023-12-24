import 'package:dungeon_paper/app/data/services/auth_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/model_utils/user_utils.dart';
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
    notifyListeners();
    messenger.showSnackBar(
      SnackBar(content: Text(tr.account.details.email.success)),
    );
  }

  void updateDisplayName(BuildContext context, String displayName) async {
    final messenger = ScaffoldMessenger.of(context);
    await userProvider.updateUser(user.copyWith(displayName: displayName));
    notifyListeners();
    messenger.showSnackBar(
      SnackBar(content: Text(tr.account.details.displayName.success)),
    );
  }

  void updatePassword(BuildContext context, String password) async {
    final messenger = ScaffoldMessenger.of(context);
    await authProvider.fbUser!.updatePassword(password);
    notifyListeners();
    messenger.showSnackBar(
      SnackBar(content: Text(tr.account.details.password.success)),
    );
  }

  void unlinkProvider(BuildContext context, ProviderName providerId) async {
    final messenger = ScaffoldMessenger.of(context);
    authProvider.logoutFromProvider(providerId);
    authProvider.fbUser!.unlink(domainFromProviderName(providerId));
    notifyListeners();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          tr.account.unlink.success(
            tr.auth.providers.name(providerId.name),
          ),
        ),
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

