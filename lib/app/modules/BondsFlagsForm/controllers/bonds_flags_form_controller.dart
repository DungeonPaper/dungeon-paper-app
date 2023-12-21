import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:flutter/material.dart';

class BondsFlagsFormController extends ChangeNotifier {
  final bonds = <SessionMark>[];
  final flags = <SessionMark>[];
  final bondsDesc = <TextEditingController>[];
  final flagsDesc = <TextEditingController>[];
  late final void Function(List<SessionMark> bonds, List<SessionMark> flags)
      onChanged;
  var dirty = false;

  BondsFlagsFormController(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    assert(arguments is BondsFlagsFormArguments);
    final BondsFlagsFormArguments args = arguments as BondsFlagsFormArguments;
    bonds.addAll(args.bonds);
    bondsDesc.addAll(args.bonds
        .map((e) =>
            TextEditingController(text: e.description)..addListener(_setDirty))
        .toList());
    flags.addAll(args.flags);
    flagsDesc.addAll(args.flags
        .map((e) =>
            TextEditingController(text: e.description)..addListener(_setDirty))
        .toList());
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
  void dispose() {
    super.dispose();
    for (final ctrl in [...bondsDesc, ...flagsDesc]) {
      ctrl.removeListener(_setDirty);
    }
  }

  void save(BuildContext context) {
    final newBonds = enumerate(bonds)
        .map((e) =>
            e.value.copyWithInherited(description: bondsDesc[e.index].text))
        .where((e) => e.description.isNotEmpty)
        .toList();
    final newFlags = enumerate(flags)
        .map((e) =>
            e.value.copyWithInherited(description: flagsDesc[e.index].text))
        .where((e) => e.description.isNotEmpty)
        .toList();

    onChanged(newBonds, newFlags);
    Navigator.of(context).pop();
  }

  void _setDirty() {
    if (!dirty) {
      dirty = true;
      notifyListeners();
    }
  }
}

class BondsFlagsFormArguments {
  final List<SessionMark> bonds;
  final List<SessionMark> flags;
  final void Function(List<SessionMark> bonds, List<SessionMark> flags)
      onChanged;

  BondsFlagsFormArguments({
    required this.bonds,
    required this.flags,
    required this.onChanged,
  });
}
