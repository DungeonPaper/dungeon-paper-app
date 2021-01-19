part of 'prefs_store.dart';

// void withPrefs(Function(SharedPreferences inst) fn) async {
//   var prefs = await SharedPreferences.getInstance();
//   fn(prefs);
// }

// void sharedPrefsMiddleware(Store<DWStore> store, action, NextDispatcher next) {
//   if (action is AppInit) {
//     PrefsStore.loadAll();
//   }

//   if (action is SetPrefs) {
//     withPrefs((prefs) {
//       prefs.setString(
//           sharedPrefsKeyMap[SharedPrefKeys.userEmail], action.prefs.user.id);
//       prefs.setString(
//           sharedPrefsKeyMap[SharedPrefKeys.userId], action.prefs.user.email);
//       prefs.setString(
//         sharedPrefsKeyMap[SharedPrefKeys.characterId],
//         action.prefs.user.lastCharacterId,
//       );
//     });
//   }

//   if (action is SetCurrentChar) {
//     withPrefs((prefs) {
//       prefs.setString(sharedPrefsKeyMap[SharedPrefKeys.characterId],
//           action.character.documentID);
//     });
//   }

//   if (action is ClearCharacters) {
//     withPrefs((prefs) {
//       prefs.remove(sharedPrefsKeyMap[SharedPrefKeys.characterId]);
//     });
//   }

//   if (action is Login) {
//     withPrefs((prefs) {
//       prefs.setString(
//           sharedPrefsKeyMap[SharedPrefKeys.userId], action.user.documentID);
//       prefs.setString(
//           sharedPrefsKeyMap[SharedPrefKeys.userEmail], action.user.email);
//     });
//   }

//   if (action is Logout) {
//     withPrefs((prefs) {
//       prefs.remove(sharedPrefsKeyMap[SharedPrefKeys.userId]);
//       prefs.remove(sharedPrefsKeyMap[SharedPrefKeys.userEmail]);
//       prefs.remove(sharedPrefsKeyMap[SharedPrefKeys.characterId]);
//     });
//   }

//   if (action is ChangeSetting) {
//     withPrefs((prefs) {
//       PrefsSettings.setToPrefs(prefs, action.name, action.value);
//     });
//   }

//   next(action);
// }
