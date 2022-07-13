import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BondsFlagsFormController extends GetxController {
  final bonds = <SessionMark>[].obs;
  final flags = <SessionMark>[].obs;
  final bondsDesc = <TextEditingController>[].obs;
  final flagsDesc = <TextEditingController>[].obs;
  late final void Function(List<SessionMark> bonds, List<SessionMark> flags) onChanged;
  final dirty = false.obs;

  @override
  void onReady() {
    super.onReady();
    final BondsFlagsFormArguments args = Get.arguments;
    bonds.value = args.bonds;
    bondsDesc.value = args.bonds
        .map((e) => TextEditingController(text: e.description)..addListener(_setDirty))
        .toList();
    flags.value = args.flags;
    flagsDesc.value = args.flags
        .map((e) => TextEditingController(text: e.description)..addListener(_setDirty))
        .toList();
    onChanged = args.onChanged;
  }

  void addBond() {
    bonds.add(SessionMark.bond(
      key: uuid(),
      description: '',
      completed: false,
    ));
    bondsDesc.add(TextEditingController()..addListener(_setDirty));
  }

  void removeBond(int index) {
    bonds.removeAt(index);
    bondsDesc[index].removeListener(_setDirty);
    bondsDesc.removeAt(index);
  }

  void addFlag() {
    flags.add(SessionMark.flag(
      key: uuid(),
      description: '',
      completed: false,
    ));
    flagsDesc.add(TextEditingController()..addListener(_setDirty));
  }

  void removeFlag(int index) {
    flags.removeAt(index);
    flagsDesc[index].removeListener(_setDirty);
    flagsDesc.removeAt(index);
  }

  @override
  void onClose() {
    for (final ctrl in [...bondsDesc, ...flagsDesc]) {
      ctrl.removeListener(_setDirty);
    }
    super.onClose();
  }

  void save() {
    final newBonds = enumerate(bonds)
        .map((e) => e.value.copyWithInherited(description: bondsDesc[e.index].text))
        .where((e) => e.description.isNotEmpty)
        .toList();
    final newFlags = enumerate(flags)
        .map((e) => e.value.copyWithInherited(description: flagsDesc[e.index].text))
        .where((e) => e.description.isNotEmpty)
        .toList();

    onChanged(newBonds, newFlags);
    Get.back();
  }

  void _setDirty() {
    if (!dirty.value) {
      dirty.value = true;
    }
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
