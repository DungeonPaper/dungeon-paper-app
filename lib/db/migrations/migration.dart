import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Migration {
  final String name;
  final Map<String, dynamic> Function(Map<String, dynamic> data) run;
  final bool Function(Map<String, dynamic> data) condition;

  Migration(this.name, this.run, [this.condition]);
}

abstract class MigrationRunner<T> {
  List<Migration> get migrations;

  T fromJson(Map<String, dynamic> data, DocumentReference reference);

  Future<T> run(DocumentSnapshot snapshot) async {
    final data = await getData(snapshot.data(), false);
    if (data != null && data.isNotEmpty) {
      await _updateRef(data, snapshot.reference);
    }
    return fromJson(data ?? snapshot.data(), snapshot.reference);
  }

  Future<List<T>> runAll(Iterable<DocumentSnapshot> snapshots) =>
      Future.wait(snapshots.map(
        (snapshot) => run(snapshot),
      ));

  Future<Map<String, dynamic>> getData(Map<String, dynamic> data,
      [bool returnAll = true]) async {
    final updates = <String, dynamic>{};

    migrations.forEach((migration) {
      debugPrint('Checking migration: ${migration.name}');
      if (migration.condition == null || !migration.condition(data)) {
        return;
      }
      final result = migration.run(data);
      if (result == null || result.isEmpty) {
        return;
      }
      updates.addAll(result);
      debugPrint('Migrated: ${migration.name}, updated keys: ${result.keys}');
    });

    if (updates.isEmpty) {
      return returnAll ? data : null;
    }

    debugPrint('Done running all migrations.');
    return returnAll ? {...data, ...updates} : updates;
  }

  Future<void> _updateRef(
      Map<String, dynamic> data, DocumentReference ref) async {
    debugPrint('Saving ${data.keys}...');
    await ref.update(data);
    debugPrint('Done saving data.');
  }
}
