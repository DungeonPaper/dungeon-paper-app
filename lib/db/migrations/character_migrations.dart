import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/utils/utils.dart';

class CharacterMigrations {
  static Character run(DocumentSnapshot snapshot) {
    final keys = <String>{};
    final data = _runAllMigrations(snapshot, keys);
    return Character.fromJson(
      data,
      ref: snapshot.reference,
    );
  }

  static Map<String, dynamic> _runAllMigrations(
      DocumentSnapshot snapshot, Set<String> keys) {
    final data = snapshot.data();

    __migration001_settings(data, keys);

    if (keys.isNotEmpty) {
      snapshot.reference.update(
        pick(data, keys),
      );
    }
    return data;
  }

  static void __migration001_settings(
      Map<String, dynamic> data, Set<String> keys) {
    if (data['useDefaultMaxHP'] != null && data['settings'] == null) {
      data['settings'] = {'useDefaultMaxHp': data.remove('useDefaultMaxHP')};
      keys.addAll(['settings', 'useDefaultMaxHP']);
    }
  }
}
