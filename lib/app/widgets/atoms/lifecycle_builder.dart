import 'package:flutter/material.dart';

class LifecycleView extends StatefulWidget {
  final void Function()? onInit;
  final void Function()? onDispose;
  final Widget Function(BuildContext) builder;
  final Widget? child;

  LifecycleView({
    Key? key,
    this.onInit,
    this.onDispose,
    required this.child,
  })  : assert(child != null),
        builder = childBuilder(child!),
        super(key: key);

  const LifecycleView.builder({
    Key? key,
    this.onInit,
    this.onDispose,
    required this.builder,
  })  : child = null,
        super(key: key);

  static Widget Function(BuildContext context) childBuilder(Widget child) => (_) => child;

  @override
  _OnInitBuilderState createState() => _OnInitBuilderState();
}

class _OnInitBuilderState extends State<LifecycleView> {
  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
