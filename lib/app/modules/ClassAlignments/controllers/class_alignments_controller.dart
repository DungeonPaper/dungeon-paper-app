import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassAlignmentsController extends GetxController {
  final alignments = AlignmentValues.empty().obs;
  final selected = Rx<dw.AlignmentType?>(null);
  bool selectable = false;
  bool editable = false;
  late final void Function(AlignmentValues alignments, dw.AlignmentType? selected)? onChanged;
  final sortedAlignmentTypes = dw.AlignmentType.values.toList();
  final editing = <dw.AlignmentType, bool>{}.obs;
  final textControllers = <dw.AlignmentType, TextEditingController>{}.obs;

  @override
  void onInit() {
    super.onInit();
    final ClassAlignmentsArguments? args = Get.arguments;
    if (args != null) {
      if (args.alignments != null) {
        alignments.value = args.alignments!;
      }
      selectable = args.selectable;
      editable = args.editable;
      onChanged = args.onChanged;
      if (args.preselected != null) {
        selected.value = args.preselected!;
      }
    }
    textControllers.addAll({
      for (final alignment in sortedAlignmentTypes)
        alignment: TextEditingController(
          text: alignments.value.byType(alignment),
        ),
    });
  }

  void toggleEdit(dw.AlignmentType type, [bool? value]) {
    editing[type] ??= false;
    editing[type] = value ?? !editing[type]!;
  }

  void select(dw.AlignmentType type) {
    selected.value = type;
  }

  bool isEditing(dw.AlignmentType type) => editable && editing[type] == true;
  bool isSelected(dw.AlignmentType type) => selectable && selected.value == type;

  void save() {
    final updated = alignments.value.copyWithInherited(
      good: textControllers[dw.AlignmentType.good]!.text,
      lawful: textControllers[dw.AlignmentType.lawful]!.text,
      neutral: textControllers[dw.AlignmentType.neutral]!.text,
      chaotic: textControllers[dw.AlignmentType.chaotic]!.text,
      evil: textControllers[dw.AlignmentType.evil]!.text,
    );

    onChanged?.call(updated, selected.value);
    Get.back();
  }
}

class ClassAlignmentsArguments {
  final AlignmentValues? alignments;
  final void Function(AlignmentValues alignments, dw.AlignmentType? selected)? onChanged;
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
