import 'package:dungeon_paper/db/helpers/character_utils.dart';
import 'package:dungeon_paper/src/atoms/card_list_item.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/alignment.dart' as dw;
import 'package:flutter/material.dart';

class EditableAlignment extends StatefulWidget {
  final dw.Alignment alignment;
  final void Function(dw.Alignment) onUpdate;

  const EditableAlignment({
    Key key,
    this.alignment,
    this.onUpdate,
  }) : super(key: key);
  @override
  _EditableAlignmentState createState() => _EditableAlignmentState();
}

class _EditableAlignmentState extends State<EditableAlignment> {
  TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController.fromValue(
      TextEditingValue(text: widget.alignment.description ?? ''),
    )..addListener(_update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var alignment = widget.alignment;
    return CardListItem(
      leading: Icon(icon, size: 40),
      title: Text(alignment.name),
      margin: EdgeInsets.all(0),
      subtitle: TextField(
        decoration:
            InputDecoration(hintText: "Enter a description or leave empty"),
        controller: controller,
      ),
    );
  }

  void _update() {
    widget.onUpdate?.call(_getAlignment());
  }

  get icon => ALIGNMENT_ICON_MAP[AlignmentName.values
      .firstWhere((element) => widget.alignment.key == enumName(element))];

  dw.Alignment _getAlignment() {
    return dw.Alignment.fromJSON({
      ...widget.alignment.toJSON(),
      'description': controller.value.text,
    });
  }
}
