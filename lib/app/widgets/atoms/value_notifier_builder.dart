import 'package:flutter/widgets.dart';

class ValueNotifierBuilder<T> extends StatefulWidget {
  const ValueNotifierBuilder({
    super.key,
    required this.value,
    required this.builder,
  });

  final ValueNotifier<T> value;
  final Widget Function(BuildContext context, dynamic value) builder;

  @override
  _ValueNotifierBuilderState createState() => _ValueNotifierBuilderState();
}

class _ValueNotifierBuilderState extends State<ValueNotifierBuilder> {
  dynamic get value => widget.value.value;

  @override
  void initState() {
    super.initState();
    widget.value.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value);
  }
}
