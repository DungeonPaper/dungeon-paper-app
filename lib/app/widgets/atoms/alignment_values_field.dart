import 'package:dungeon_paper/app/modules/ClassAlignments/controllers/class_alignments_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import '../../data/models/alignment.dart';

class AlignmentValuesField extends StatefulWidget {
  final ValueNotifier<AlignmentValues> controller;
  const AlignmentValuesField({super.key, required this.controller});

  @override
  State<AlignmentValuesField> createState() => _AlignmentValuesFieldState();
}

class _AlignmentValuesFieldState extends State<AlignmentValuesField> {
  late AlignmentValues _alignmentValues;

  @override
  void initState() {
    _alignmentValues = widget.controller.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr.alignment.alignmentValues.title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 16,
          children: _alignmentValues.values
                  .map((e) => _buildAlignmentValue(e))
                  .toList() +
              [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: Text(tr.generic.edit),
                  onPressed: _openEditor(context),
                ),
              ],
        ),
      ],
    );
  }

  void Function() _openEditor(BuildContext context) {
    return () async {
      Navigator.of(context).pushNamed(
        Routes.classAlignments,
        arguments: ClassAlignmentsArguments(
          alignments: _alignmentValues,
          editable: true,
          selectable: false,
          onChanged: (alignments, selected) {
            setState(() {
              _alignmentValues = alignments;
              widget.controller.value = alignments;
            });
          },
        ),
      );
    };
  }

  Widget _buildAlignmentValue(AlignmentValue value) {
    final desc = _alignmentValues.byType(value.type);
    final hasValue = desc.isNotEmpty;

    return PrimaryChip(
      // backgroundColor: color,
      isEnabled: hasValue,
      icon: Icon(AlignmentValue.iconOf(value.type)),
      label: tr.alignment.name(value.type.name),
      tooltip: desc,
    );
  }
}

