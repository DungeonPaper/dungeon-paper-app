import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/spell.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:uuid/uuid.dart';

import 'character.dart';

ReturnPredicate<DbSpell> matchSpell =
    matcher<DbSpell>((DbSpell i, DbSpell o) => i.key == o.key);

class DbSpell extends Spell {
  bool prepared;

  DbSpell({
    String key,
    String name,
    String description,
    String level,
    List<Tag> tags,
    this.prepared = false,
  }) : super(
          key: key ?? Uuid().v4(),
          name: name,
          description: description,
          level: level,
          tags: tags,
        );

  static DbSpell fromSpell(Spell spell, {bool prepared = false}) {
    return DbSpell(
      key: spell.key,
      name: spell.name,
      description: spell.description,
      level: spell.level,
      tags: spell.tags,
      prepared: prepared,
    );
  }

  static DbSpell fromJSON(Map map) {
    var orig = Spell.fromJSON(map);
    return DbSpell.fromSpell(orig, prepared: map['prepared'] ?? false);
  }

  @override
  Map toJSON() {
    var map = super.toJSON();
    map['prepared'] = prepared;
    return map;
  }

  @override
  DbSpell copy() => DbSpell.fromJSON(toJSON());
}

Future<void> updateSpell(Character character, DbSpell spell) => character
    .copyWith(spells: findAndReplaceInList(character.spells, spell))
    .update(keys: ['spells']);

Future<void> deleteSpell(Character character, DbSpell spell) => character
    .copyWith(spells: removeFromList(character.spells, spell))
    .update(keys: ['spells']);

Future<void> createSpell(Character character, DbSpell spell) => character
    .copyWith(spells: addToList(character.spells, spell))
    .update(keys: ['spells']);
