import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownHelp extends StatelessWidget {
  static TextSpan comma = TextSpan(text: ',\u00a0');
  static TextStyle linkStyle = TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.solid);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              children: [
                TextSpan(
                    text: 'Markdown',
                    style: linkStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = openMarkdownHelp),
                TextSpan(text: ' cheat sheet:'),
              ],
            ),
            TextSpan(
                text: '\n**bold**',
                style: TextStyle(fontWeight: FontWeight.bold)),
            comma,
            TextSpan(
                text: ' *italic*',
                style: TextStyle(fontStyle: FontStyle.italic)),
            comma,
            TextSpan(
              children: [
                TextSpan(text: ' '),
                TextSpan(text: '[link](http://a.b)', style: linkStyle),
              ],
            ),
            TextSpan(text: '\n* bullet'),
            TextSpan(text: '\n1. numbered list'),
            TextSpan(text: '\n# largest title'),
            TextSpan(text: '\n###### smallest title'),
          ],
        ),
      ),
    );
  }

  void openMarkdownHelp() {
    launch('https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet');
  }
}
