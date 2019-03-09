import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';

class WheelSlider extends StatefulWidget {
  final Function(double value) onSlideUpdate;
  final double width;
  final double height;
  final double value;
  final double min;
  final double max;
  final Widget Function(double value) labelBuilder;

  const WheelSlider({
    Key key,
    @required this.onSlideUpdate,
    this.width = 60,
    this.height = 100,
    this.min = double.negativeInfinity,
    this.max = double.infinity,
    this.value = 0.5,
    this.labelBuilder,
  }) : super(key: key);

  @override
  _WheelSliderState createState() => _WheelSliderState(value: value);
}

class _WheelSliderState extends State<WheelSlider> {
  double value;
  double dragValue;
  Offset dragOffset;

  _WheelSliderState({this.value});

  @override
  Widget build(BuildContext context) {
    const double shadowOffset = 0.2;

    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  widget.max.round().toString(),
                  textScaleFactor: 0.75,
                ),
                Text(
                  widget.min.round().toString(),
                  textScaleFactor: 0.75,
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onVerticalDragStart: (details) {
            print("dragStart: ${details.globalPosition}");
            setState(() {
              dragOffset = details.globalPosition;
              dragValue = value;
            });
          },
          onVerticalDragUpdate: (details) {
            print("dragUpdate: ${details.globalPosition}");
            setState(() {
              value = clamp(
                  dragValue - (details.globalPosition - dragOffset).dy / 20.0,
                  widget.min,
                  widget.max);
              if (widget.onSlideUpdate != null) {
                widget.onSlideUpdate(value);
              }
            });
          },
          onVerticalDragEnd: (details) {
            print("dragEnd: ${details.velocity}");
            setState(() {
              dragOffset = null;
            });
          },
          child: SizedBox.fromSize(
            size: Size(widget.width.toDouble(), widget.height.toDouble()),
            child: Container(
              child: Stack(
                children: List<Widget>.generate(
                      20,
                      (i) {
                        double valueFraction = (value.ceil() - value) * 10;
                        double top =
                            (widget.height / 10 * i) - widget.height / 2;
                        top += valueFraction;
                        return Positioned.fromRect(
                          rect: Rect.fromLTWH(
                            0.0,
                            top,
                            widget.width.toDouble(),
                            0,
                          ),
                          child: Divider(
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    ).toList() +
                    (widget.labelBuilder != null
                        ? [widget.labelBuilder(value)]
                        : []),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, shadowOffset, 1.0 - shadowOffset, 1.0],
                  colors: [
                    Colors.grey[350],
                    Colors.grey[50],
                    Colors.grey[50],
                    Colors.grey[350]
                  ],
                ),
                border: Border.all(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.grey[600],
                ),
                borderRadius: BorderRadius.circular(3.5),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '+',
                  textScaleFactor: 0.75,
                ),
                Text(
                  '-',
                  textScaleFactor: 0.75,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
