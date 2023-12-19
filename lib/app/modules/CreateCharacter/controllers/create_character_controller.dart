import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/bio.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/character_stats.dart';
import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CreateCharacterController extends ChangeNotifier {
  var name = '';
  var avatarUrl = '';
  CharacterClass? characterClass;
  var abilityScores = AbilityScores.dungeonWorldAll(10);
  var startingGear = <GearSelection>[];
  var moves = <Move>[];
  var spells = <Spell>[];
  AlignmentValue? alignment;
  Race? race;

  var dirty = false;

  static CreateCharacterController of(BuildContext context) =>
      Provider.of<CreateCharacterController>(context, listen: false);
  static Widget consumer(
    Widget Function(BuildContext, CreateCharacterController, Widget?) builder,
  ) =>
      Consumer<CreateCharacterController>(builder: builder);

  bool get isValid => [
        name.isNotEmpty,
        characterClass != null,
        alignment != null,
        race != null,
      ].every((element) => element == true);

  List<Item> get items =>
      GearChoice.selectionToItems(startingGear, equipped: true);

  double get coins => GearChoice.selectionToCoins(startingGear);

  void setBasicInfo(String name, String avatar) {
    this.name = name;
    avatarUrl = avatar;
    setDirty();
  }

  void setClass(BuildContext context, CharacterClass cls) {
    characterClass = cls;
    setStartingGear(
      cls.gearChoices
          .fold([], (all, cur) => [...all, ...cur.preselectedGearSelections]),
    );
    addStartingMoves(context);
    setDirty();
  }

  void setAbilityScores(AbilityScores stats) {
    abilityScores = stats;
    setDirty();
  }

  void setAlignment(AlignmentValues alignments, dw.AlignmentType? selected) {
    if (selected == null) {
      return;
    }
    alignment = AlignmentValue.empty(type: selected).copyWith(
      description: alignments.byType(selected),
    );
    setDirty();
  }

  void setMovesAndSpells(List<Move> moves, List<Spell> spells) {
    this.moves.clear();
    this.spells.clear();
    this.moves.addAll(moves.map((e) => e.copyWithInherited(favorite: true)));
    this.spells.addAll(spells.map((e) => e.copyWithInherited(prepared: true)));
  }

  void setDirty() {
    dirty = true;
  }

  void setStartingGear(List<GearSelection> selections) {
    startingGear.clear();
    startingGear.addAll(selections);
  }

  void addStartingMoves(BuildContext context) {
    final repo = RepositoryProvider.of(context);
    moves.clear();
    moves.addAll(
      [...repo.builtIn.moves.values, ...repo.my.moves.values]
          .where((m) => (m.classKeys.contains(characterClass!.reference) &&
              m.category == MoveCategory.starting))
          .map(
            // favorite: move.category != MoveCategory.basic
            (move) => Move.fromDwMove(move, favorite: true),
          )
          .toList(),
    );
  }

  Character getAsCharacter() => Character.empty().copyWith(
        displayName: name,
        avatarUrl: avatarUrl,
        characterClass: characterClass,
        abilityScores: abilityScores,
        moves: moves,
        spells: spells,
        items: items,
        coins: coins,
        race: race,
        stats: CharacterStats(
          level: 1,
          currentHp: characterClass!.hp + abilityScores.conMod!,
          currentXp: 0,
        ),
        sessionMarks: [
          ...(characterClass?.bonds
                  .map((bond) => SessionMark.bond(
                      description: bond, completed: false, key: uuid()))
                  .toList() ??
              []),
          ...Character.defaultEndOfSessionMarks,
        ],
        bio: Bio(
          looks: '',
          description: '',
          alignment: alignment ?? AlignmentValue.empty(),
        ),
      );
}

