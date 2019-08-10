import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  final EdgeInsets padding;
  final String text;
  final String url;

  const Hyperlink(
    this.text,
    this.url, {
    Key key,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: TextStyle(
            color: Color.fromRGBO(25, 118, 210, 1),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      onTap: () => launch(url),
    );
  }
}
