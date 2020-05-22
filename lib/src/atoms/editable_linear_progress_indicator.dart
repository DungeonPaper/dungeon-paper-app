import 'package:flutter/material.dart';

class EditableLinearProgressIndicator extends StatefulWidget {
  const EditableLinearProgressIndicator({
    Key key,
    @required this.backgroundColor,
    @required this.valueColor,
    @required this.value,
    this.onEditEnd,
    this.onEditUpdate,
    this.onEditStart,
  }) : super(key: key);

  final Color backgroundColor;
  final Animation valueColor;
  final double value;
  final void Function(double val) onEditStart;
  final void Function(double val) onEditEnd;
  final void Function(double val) onEditUpdate;

  @override
  EditableLinearProgressIndicatorState createState() => EditableLinearProgressIndicatorState();
}

class EditableLinearProgressIndicatorState extends State<EditableLinearProgressIndicator> {
  double value;
  DateTime touchStart;
  bool editing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: () {
        setState(() {
          editing = true;
        });
      },
      onTapUp: (details) {
        if (editing) {
          setState(() {
            editing = false;
          });
        }
      },
      onHorizontalDragStart: (details) {
        if (widget.onEditStart != null) {
          widget.onEditStart(value);
        }
      },
      onHorizontalDragUpdate: (details) {
        if (editing) {
          updateValueByTouchPos(context, details.globalPosition);
          if (widget.onEditUpdate != null) {
            widget.onEditUpdate(value);
          }
        }
      },
      onHorizontalDragEnd: (details) {
        setState(() {
          touchStart = null;
          editing = false;
        });
        if (widget.onEditEnd != null) {
          widget.onEditEnd(value);
        }
      },
      child: Container(
        decoration: !editing
            ? null
            : BoxDecoration(border: Border.all(color: Colors.green, width: 2)),
        child: LinearProgressIndicator(
          backgroundColor: widget.backgroundColor,
          valueColor: widget.valueColor,
          value: widget.value.clamp(0.0, 1.0),
        ),
      ),
    );
  }

  void updateValueByTouchPos(BuildContext context, Offset globalPosition) {
    RenderBox rect = context.findRenderObject();
    Offset offset = rect.globalToLocal(globalPosition);
    num width = rect.size.width;
    num x = offset.dx.clamp(0, width);
    setState(() {
      value = x / width;
    });
  }
}
