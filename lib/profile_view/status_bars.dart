import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/actions/character_actions.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';

class StatusBars extends StatelessWidget {
  // StatusBars({Key key}) : super(key: key);
  static const double _PROGRESS_HEIGHT = 20;
  static const double _VALUE_WIDTH = 80;
  static const valueStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const labelStyle =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w300, letterSpacing: -1);

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector(
      builder: (context, state) {
        DbCharacter character = state.characters.current;
        Color hpBg = Colors.red.shade100;
        Animation<Color> hpValueColor =
            AlwaysStoppedAnimation(Colors.red.shade700);
        double hpPerc =
            character.currentHP > 0 ? character.currentHP / character.maxHP : 0;
        Color xpBg = Colors.lightBlue.shade100;
        Animation<Color> xpValueColor = AlwaysStoppedAnimation(Colors.blue);
        double xpPerc = character.currentXP > 0
            ? character.currentXP / (character.level + 7)
            : 0;
        return Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('HP', style: labelStyle),
                          SizedBox(
                            width: _VALUE_WIDTH,
                            child: Center(
                              child: Text(
                                  '${character.currentHP}/${character.maxHP}',
                                  style: valueStyle),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          height: _PROGRESS_HEIGHT,
                          child: EditableProgressBar(
                            backgroundColor: hpBg,
                            valueColor: hpValueColor,
                            value: hpPerc,
                            onEditUpdate: (value) => dwStore.dispatch(
                                CharacterActions.updateField('currentHP',
                                    (value * character.maxHP).round())),
                            onEditEnd: (value) => updateCharacter({
                                  'currentHP': (value * character.maxHP).round()
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                  child: Row(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('XP', style: labelStyle),
                          SizedBox(
                            width: _VALUE_WIDTH,
                            child: Center(
                              child: Text(
                                  '${character.currentXP}/${character.level * 7}',
                                  style: valueStyle),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          height: _PROGRESS_HEIGHT,
                          child: EditableProgressBar(
                            backgroundColor: xpBg,
                            valueColor: xpValueColor,
                            value: xpPerc,
                            onEditUpdate: (value) => dwStore.dispatch(
                                CharacterActions.updateField('currentXP',
                                    (value * (character.level + 7)).round())),
                            onEditEnd: (value) => updateCharacter({
                                  'currentXP':
                                      (value * (character.level + 7)).round()
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class EditableProgressBar extends StatefulWidget {
  const EditableProgressBar({
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
  EditableProgressBarState createState() => EditableProgressBarState();
}

class EditableProgressBarState extends State<EditableProgressBar> {
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
