import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/spell.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:uuid/uuid.dart';

ReturnPredicate<Spell> matchSpell =
    matcher<Spell>((Spell i, Spell o) => i.key == o.key);

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
    return DbSpell.fromSpell(orig, prepared: map['prepared']);
  }

  @override
  Map toJSON() {
    Map map = super.toJSON();
    map['prepared'] = prepared;
    return map;
  }
}

Future updateSpell(Spell spell) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  num index = character.spells.indexWhere(matchSpell(spell));
  character.spells[index] = spell;
  await updateCharacter(character, [CharacterKeys.spells]);
}

Future deleteSpell(Spell spell) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  num index = character.spells.indexWhere(matchSpell(spell));
  character.spells.removeAt(index);
  await updateCharacter(character, [CharacterKeys.spells]);
}

Future createSpell(Spell spell) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.spells.add(spell);
  await updateCharacter(character, [CharacterKeys.spells]);
}
