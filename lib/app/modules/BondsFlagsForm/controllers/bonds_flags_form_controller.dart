import 'package:dungeon_paper/app/data/models/session_marks.dart';
import 'package:dungeon_paper/core/route_arguments.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:flutter/material.dart';

class BondsFlagsFormController extends ChangeNotifier {
  final bonds = <SessionMark>[];
  final flags = <SessionMark>[];
  final bondsCtrls = <TextEditingController>[];
  final flagsCtrls = <TextEditingController>[];
  late final void Function(List<SessionMark> bonds, List<SessionMark> flags)
      onChanged;
  var dirty = false;

  BondsFlagsFormController(BuildContext context) {
    final BondsFlagsFormArguments args = getArgs(context);
    bonds.addAll(args.bonds);
    bondsCtrls.addAll(args.bonds
        .map(
          (e) => TextEditingController(text: e.description)
            ..addListener(_setDirty),
        )
        .toList());
    flags.addAll(args.flags);
    flagsCtrls.addAll(args.flags
        .map(
          (e) => TextEditingController(text: e.description)
            ..addListener(_setDirty),
        )
        .toList());
    onChanged = args.onChanged;
  }

  void addBond() {
    bonds.add(SessionMark.bond(
      key: uuid(),
      description: '',
      completed: false,
    ));
    bondsCtrls.add(TextEditingController()..addListener(_setDirty));
    _setDirty();
    notifyListeners();
  }

  void removeBond(int index) {
    debugPrint('remove bond $index');
    bonds.removeAt(index);
    bondsCtrls[index].removeListener(_setDirty);
    bondsCtrls.removeAt(index);
    _setDirty();
    notifyListeners();
  }

  void addFlag() {
    flags.add(SessionMark.flag(
      key: uuid(),
      description: '',
      completed: false,
    ));
    flagsCtrls.add(TextEditingController()..addListener(_setDirty));
    _setDirty();
    notifyListeners();
  }

  void removeFlag(int index) {
    flags.removeAt(index);
    flagsCtrls[index].removeListener(_setDirty);
    flagsCtrls.removeAt(index);
    _setDirty();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    for (final ctrl in [...bondsCtrls, ...flagsCtrls]) {
      ctrl.removeListener(_setDirty);
    }
  }

  void save(BuildContext context) {
    final newBonds = enumerate(bonds)
        .map((e) =>
            e.value.copyWithInherited(description: bondsCtrls[e.index].text))
        .where((e) => e.description.isNotEmpty)
        .toList();
    final newFlags = enumerate(flags)
        .map((e) =>
            e.value.copyWithInherited(description: flagsCtrls[e.index].text))
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
