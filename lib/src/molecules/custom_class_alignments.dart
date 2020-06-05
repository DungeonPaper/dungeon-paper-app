import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/molecules/editable_alignment.dart';
import 'package:dungeon_paper/src/utils/types.dart';
import 'package:dungeon_world_data/alignment.dart' as dw;
import 'package:flutter/material.dart';

class CustomClassAlignments extends StatefulWidget {
  final Map<String, dw.Alignment> alignments;
  final VoidCallbackDelegate<Map<String, dw.Alignment>> onUpdate;
  final DialogMode mode;

  const CustomClassAlignments({
    Key key,
    this.alignments = const {},
    this.onUpdate,
    @required this.mode,
  }) : super(key: key);

  @override
  _CustomClassAlignmentsState createState() => _CustomClassAlignmentsState();
}

class _CustomClassAlignmentsState extends State<CustomClassAlignments> {
  Map<String, dw.Alignment> alignments;
  List<ValueNotifier> validities;

  @override
  void initState() {
    alignments = Map<String, dw.Alignment>.from(widget.alignments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CategorizedList.builder(
        items: alignments.values.toList(),
        itemMargin: EdgeInsets.all(8),
        itemCount: (cat, i) => 1,
        itemBuilder: _childBuilder,
      ),
    );
  }

  Widget _childBuilder(BuildContext context, alignment, num i, num catI) =>
      EditableAlignment(
        alignment: alignment,
        onUpdate: (_alignment) => _update(_alignment),
      );

  void _update(dw.Alignment alignment) {
    setState(() {
      alignments[alignment.key] = alignment;
    });
    widget.onUpdate?.call(alignments);
  }
}
