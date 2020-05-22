import 'package:flutter/material.dart';

class SlideRouteFromRight extends StatelessWidget {
  final Widget child;
  final Animation<double> inAnim;
  final Animation<double> outAnim;

  const SlideRouteFromRight({
    Key key,
    @required this.child,
    @required this.inAnim,
    @required this.outAnim,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(inAnim),
      child: SlideTransition(
        position:
            Tween(begin: Offset(1.0, 0.0), end: Offset.zero).animate(inAnim),
        child: FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.0).animate(outAnim),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(1.0, 0.0),
            ).animate(outAnim),
            child: child,
          ),
        ),
      ),
    );
  }
}
