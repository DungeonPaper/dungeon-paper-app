import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
    required BuildContext context,
    this.title,
    required String content,
  }) : super(content: _getContent(context, title, content));

  final String? title;

  static Widget _getContent(
      BuildContext context, String? title, String content) {
    if (title != null && title.isNotEmpty) {
      return Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyLarge),
          Text(content),
        ],
      );
    }
    return Text(content);
  }

  static show(BuildContext context, {String? title, required String content}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(context: context, title: title, content: content),
      );

  static deferred(BuildContext context) => DeferredCustomSnackBar._(context);
}

class DeferredCustomSnackBar {
  DeferredCustomSnackBar._(this.context);
  BuildContext context;

  show({
    String? title,
    required String content,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(context: context, title: title, content: content),
      );
}

