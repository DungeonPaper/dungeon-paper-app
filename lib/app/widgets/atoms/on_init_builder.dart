import 'package:flutter/material.dart';

class OnInit extends StatefulWidget {
  final void Function() onInit;
  final Widget Function(BuildContext) builder;
  final Widget? child;

  OnInit({
    Key? key,
    required this.onInit,
    required this.child,
  })  : assert(child != null),
        builder = childBuilder(child!),
        super(key: key);

  const OnInit.builder({
    Key? key,
    required this.onInit,
    required this.builder,
  })  : child = null,
        super(key: key);

  static Widget Function(BuildContext context) childBuilder(Widget child) => (_) => child;

  @override
  _OnInitBuilderState createState() => _OnInitBuilderState();
}

class _OnInitBuilderState extends State<OnInit> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
