import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hyperlink<T> extends StatelessWidget {
  final EdgeInsets padding;
  final T text;
  final String url;
  final void Function() onTap;

  const Hyperlink({
    Key key,
    @required this.text,
    this.url,
    this.onTap,
    this.padding = const EdgeInsets.all(0),
  })  : assert(onTap != null || url != null),
        assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: padding,
        child: DefaultTextStyle(
          style: TextStyle(
            color: Color.fromRGBO(25, 118, 210, 1),
            decoration: TextDecoration.underline,
          ),
          child: text is Widget ? text : Text(text.toString()),
        ),
      ),
      onTap: onTap ?? () => launch(url),
    );
  }
}
