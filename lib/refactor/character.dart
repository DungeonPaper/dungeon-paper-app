import 'dart:math';

import 'package:pedantic/pedantic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/refactor/firebase_entity/firebase_entity.dart';
import 'package:dungeon_paper/db/character_utils.dart';
import 'package:dungeon_paper/db/inventory_items.dart';
import 'package:dungeon_paper/db/notes.dart';
import 'package:dungeon_paper/db/spells.dart';
import 'package:dungeon_paper/refactor/firebase_entity/fields/fields.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';

part './character_fields.dart';

class Character extends FirebaseEntity with CharacterFields {
  Character({
    Map<String, dynamic> data,
    DocumentReference ref,
  }) : super(ref: ref, data: data);

  static String statModifierText(num stat) {
    num mod = CharacterFields.statModifier(stat);
    return (mod >= 0 ? '+' : '') + mod.toString();
  }

  @override
  Future<void> update({Map<String, dynamic> json, bool save = true}) async {
    await super.update(json: json, save: save);
    if (save && docID != null) {
      dwStore.dispatch(CharacterActions.updateCharacter(this));
    }
  }

  @override
  String toString() => '$displayName (Lv. $level ${mainClass?.name})';
}
