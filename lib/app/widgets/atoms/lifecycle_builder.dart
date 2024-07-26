import 'package:flutter/material.dart';

class LifecycleView extends StatefulWidget {
  final void Function()? onInit;
  final void Function()? onDispose;
  final Widget Function(BuildContext) builder;
  final Widget? child;

  LifecycleView({
    super.key,
    this.onInit,
    this.onDispose,
    required this.child,
  })  : assert(child != null),
        builder = childBuilder(child!);

  const LifecycleView.builder({
    super.key,
    this.onInit,
    this.onDispose,
    required this.builder,
  }) : child = null;

  static Widget Function(BuildContext context) childBuilder(Widget child) =>
      (_) => child;

  @override
  _LifecycleBuilderState createState() => _LifecycleBuilderState();
}

class _LifecycleBuilderState extends State<LifecycleView> {
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
    return Builder(builder: widget.builder);
  }
}
