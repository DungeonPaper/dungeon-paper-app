import 'package:flutter/widgets.dart';

class ValueNotifierBuilder<T> extends StatefulWidget {
  const ValueNotifierBuilder({
    Key? key,
    required this.value,
    required this.builder,
  }) : super(key: key);

  final ValueNotifier<T> value;
  // TODO dynamic wtf
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
      debugPrint('value: ' + widget.value.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value);
  }
}
