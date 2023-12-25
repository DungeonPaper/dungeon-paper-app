import 'package:dungeon_paper/core/global_keys.dart';
import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
    this.title,
    required String content,
  }) : super(content: _getContent(title, content));

  final String? title;

  static Widget _getContent(
      String? title, String content) {
    if (title != null && title.isNotEmpty) {
      return Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text(content),
        ],
      );
    }
    return Text(content);
  }

  static show({String? title, required String content}) {
    final context = scaffoldMessengerKey.currentContext!;
    return ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(title: title, content: content),
    );
  }
}

