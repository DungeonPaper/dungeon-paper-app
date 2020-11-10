import 'dart:core';
import 'dart:core' as core;
import 'dart:math';

import 'package:dungeon_paper/src/inherited_widgets/inherited_character.dart';
import 'package:dungeon_paper/src/redux/characters/characters_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/utils/utils.dart';

import 'package:dungeon_world_data/dice.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/move.dart';
import 'package:dungeon_world_data/player_class.dart';

import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'character_settings.dart';
import '../../helpers/character_utils.dart';
import '../firebase_entity/firebase_entity.dart';
import '../firebase_entity/fields/fields.dart';
import '../inventory_items.dart';
import '../notes.dart';
import '../spells.dart';

part 'character_fields.dart';

class Character extends FirebaseEntity with CharacterFields {
  Character({
    Map<String, dynamic> data,
    DocumentReference ref,
    bool autoLoad,
  }) : super(ref: ref, data: data, autoLoad: autoLoad);

  static Character of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedCharacter>()
        ?.character;
  }

  static String statModifierText(num stat) {
    var mod = CharacterFields.modifierFromValue(stat);
    return (mod >= 0 ? '+' : '') + mod.toString();
  }

  @override
  Future<Map<String, dynamic>> getRemoteData() async {
    var res = await super.getRemoteData();
    dwStore.dispatch(UpsertCharacter(this));
    return res;
  }

  // @override
  // Future<void> update({Map<String, dynamic> json, bool save = true}) async {
  //   await super.update(json: json, save: save);
  //   if (save && docID != null) {
  //     dwStore.dispatch(UpdateCharacter(this));
  //   }
  // }

  @override
  void finalizeUpdate(Map<String, dynamic> json, {bool save = true}) {
    if (save) {
      dwStore.dispatch(UpsertCharacter(this));
    }
    super.finalizeUpdate(json, save: save);
  }

  @override
  String toString() => '$displayName (Lv. $level ${mainClass?.name})';
}
