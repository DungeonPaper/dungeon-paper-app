import 'package:flutter/material.dart';

class DebugDialog extends StatefulWidget {
  final String text;

  const DebugDialog({Key? key, required this.text}) : super(key: key);

  @override
  State<DebugDialog> createState() => _DebugDialogState();
}

class _DebugDialogState extends State<DebugDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Debug'),
      children: [
        TextField(
          controller: controller,
          maxLines: 15,
        )
      ],
    );
  }
}
