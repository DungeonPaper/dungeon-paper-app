import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BondsFlagsFormController extends GetxController {
  final bonds = <SessionMark>[].obs;
  final flags = <SessionMark>[].obs;
  final bondsDesc = <TextEditingController>[].obs;
  final flagsDesc = <TextEditingController>[].obs;
  late final void Function(List<SessionMark> bonds, List<SessionMark> flags) onChanged;

  @override
  void onReady() {
    super.onReady();
    final BondsFlagsFormArguments args = Get.arguments;
    bonds.value = args.bonds;
    bondsDesc.value = args.bonds.map((e) => TextEditingController(text: e.description)).toList();
    flags.value = args.flags;
    flagsDesc.value = args.flags.map((e) => TextEditingController(text: e.description)).toList();
    onChanged = args.onChanged;
  }

  void addBond() {
    bonds.add(SessionMark.bond(
      key: uuid(),
      description: '',
      completed: false,
    ));
    bondsDesc.add(TextEditingController());
  }

  void removeBond(int index) {
    bonds.removeAt(index);
    bondsDesc.removeAt(index);
  }

  void addFlag() {
    flags.add(SessionMark.flag(
      key: uuid(),
      description: '',
      completed: false,
    ));
    flagsDesc.add(TextEditingController());
  }

  void removeFlag(int index) {
    flags.removeAt(index);
    flagsDesc.removeAt(index);
  }

  void save() {
    var newBonds = enumerate(bonds)
        .map((e) => e.value.copyWithInherited(description: bondsDesc[e.index].text))
        .where((e) => e.description.isNotEmpty)
        .toList();
    var newFlags = enumerate(flags)
        .map((e) => e.value.copyWithInherited(description: flagsDesc[e.index].text))
        .where((e) => e.description.isNotEmpty)
        .toList();

    onChanged(newBonds, newFlags);
    Get.back();
  }
}

class BondsFlagsFormArguments {
  final List<SessionMark> bonds;
  final List<SessionMark> flags;
  final void Function(List<SessionMark> bonds, List<SessionMark> flags) onChanged;

  BondsFlagsFormArguments({
    required this.bonds,
    required this.flags,
    required this.onChanged,
  });
}
