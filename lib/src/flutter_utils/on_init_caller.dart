import 'package:flutter/material.dart';

class OnInitCaller extends StatefulWidget {
  final void Function() onInit;
  final Widget child;

  OnInitCaller({
    Key key,
    @required this.onInit,
    @required this.child,
  }) : super(key: key);

  @override
  _OnInitCallerState createState() => _OnInitCallerState();
}

class _OnInitCallerState extends State<OnInitCaller> {
  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
