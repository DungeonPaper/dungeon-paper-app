import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/migrations/migration.dart';
import 'package:dungeon_paper/db/models/character.dart';

class CharacterMigrations extends MigrationRunner<Character> {
  @override
  final migrations = [
    Migration('Settings', (data) {
      return <String, dynamic>{
        'settings': <String, dynamic>{
          'useDefaultMaxHp': true,
          'photoAlignment': 'topCenter',
        },
      };
    }, (data) => data['settings'] == null),
    Migration('Settings defaultMaxHp', (data) {
      final deleteOldMaxHp = <String, dynamic>{'useDefaultMaxHP': null};
      if (data['settings'] != null) {
        return deleteOldMaxHp;
      }
      return <String, dynamic>{
        ...deleteOldMaxHp,
        'settings': <String, dynamic>{
          'useDefaultMaxHp': data.remove('useDefaultMaxHP'),
        },
      };
    }, (data) => data['useDefaultMaxHP'] != null),
    Migration('Single object player class', (data) {
      return <String, dynamic>{
        // TODO uncomment line when ready to make migration final
        // 'playerClasses': null,
        'playerClass': data['playerClass'] ?? data['playerClasses'].first,
      };
    }, (data) => data['playerClasses'] != null),
  ];

  @override
  Character fromJson(Map<String, dynamic> data, DocumentReference ref) =>
      Character.fromJson(data, ref: ref);
}
