part of 'auth.dart';

UserInfo getAuthProvider(String providerId, fb.User user) =>
    user?.providerData?.firstWhere(
      (data) => data.providerId == providerId,
      orElse: () => null,
    );

UserInfo getPrimaryAuthProvider(fb.User user) => user?.providerData?.firstWhere(
      (data) => data.providerId != 'firebase',
      orElse: () => null,
    );

bool isUserLinkedToAuth(String providerId, fb.User user) =>
    user?.providerData?.any((d) => d.providerId == providerId) == true;
