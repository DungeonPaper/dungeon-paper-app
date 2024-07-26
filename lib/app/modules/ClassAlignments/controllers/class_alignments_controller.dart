import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/core/route_arguments.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

class ClassAlignmentsController extends ChangeNotifier {
  var alignments = AlignmentValues.empty();
  dw.AlignmentType? selected;
  bool selectable = false;
  bool editable = false;
  late final void Function(
      AlignmentValues alignments, dw.AlignmentType? selected)? onChanged;
  final sortedAlignmentTypes = dw.AlignmentType.values.toList();
  final editing = <dw.AlignmentType, bool>{};
  final textControllers = <dw.AlignmentType, TextEditingController>{};

  ClassAlignmentsController(BuildContext context) {
    final ClassAlignmentsArguments? args = getArgs(context, nullOk: true);
    if (args != null) {
      if (args.alignments != null) {
        alignments = args.alignments!;
      }
      selectable = args.selectable;
      editable = args.editable;
      onChanged = args.onChanged;
      if (args.preselected != null) {
        selected = args.preselected!;
      }
    }
    textControllers.addAll({
      for (final alignment in sortedAlignmentTypes)
        alignment: TextEditingController(
          text: alignments.byType(alignment),
        )..addListener(notifyListeners),
    });
  }

  void toggleEdit(dw.AlignmentType type, [bool? value]) {
    editing[type] ??= false;
    editing[type] = value ?? !editing[type]!;
    notifyListeners();
  }

  void select(dw.AlignmentType type) {
    selected = type;
    notifyListeners();
  }

  bool isEditing(dw.AlignmentType type) => editable && editing[type] == true;
  bool isSelected(dw.AlignmentType type) => selectable && selected == type;

  void save(BuildContext context) {
    final updated = alignments.copyWithInherited(
      good: textControllers[dw.AlignmentType.good]!.text,
      lawful: textControllers[dw.AlignmentType.lawful]!.text,
      neutral: textControllers[dw.AlignmentType.neutral]!.text,
      chaotic: textControllers[dw.AlignmentType.chaotic]!.text,
      evil: textControllers[dw.AlignmentType.evil]!.text,
    );

    onChanged?.call(updated, selected);
    notifyListeners();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    for (var c in textControllers.values) {
      c.dispose();
    }
  }
}

class ClassAlignmentsArguments {
  final AlignmentValues? alignments;
  final void Function(AlignmentValues alignments, dw.AlignmentType? selected)?
      onChanged;
  final bool selectable;
  final dw.AlignmentType? preselected;
  final bool editable;

  ClassAlignmentsArguments({
    required this.alignments,
    required this.selectable,
    required this.editable,
    this.onChanged,
    this.preselected,
  });
}
