import 'package:flutter/material.dart';

class TitleSubtitleRow extends StatelessWidget {
  const TitleSubtitleRow({
    Key key,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: textTheme.headline,
          ),
          Text(subtitle, style: textTheme.subhead),
        ],
      ),
    );
  }
}
