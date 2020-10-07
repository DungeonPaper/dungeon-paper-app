part of 'auth.dart';

UserInfo getAuthProvider(String providerId, FirebaseUser user) =>
    user.providerData.firstWhere(
      (data) => data.providerId == providerId,
      orElse: () => null,
    );

UserInfo getPrimaryAuthProvider(FirebaseUser user) =>
    user.providerData.firstWhere(
      (data) => data.providerId != 'firebase',
      orElse: () => null,
    );

bool isUserLinkedToAuth(String providerId, FirebaseUser user) =>
    user.providerData.any((d) => d.providerId == providerId);
