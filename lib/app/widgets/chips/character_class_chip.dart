import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_world_data/entity_reference.dart';
import 'package:flutter/material.dart';

import '../../data/models/character_class.dart';

class CharacterClassChip extends StatelessWidget {
  const CharacterClassChip({
    super.key,
    required this.characterClass,
    this.visualDensity,
  });

  CharacterClassChip.fromClass({
    super.key,
    required CharacterClass cls,
    this.visualDensity,
  }) : characterClass = cls.reference;

  final EntityReference characterClass;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    return PrimaryChip(
      icon: Icon(CharacterClass.genericIcon),
      label: characterClass.name,
      visualDensity: visualDensity ?? VisualDensity.compact,
    );
  }
}
