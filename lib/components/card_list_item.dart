import 'package:flutter/material.dart';

class CardListItem extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget leading;
  final Widget trailing;
  final VoidCallback onTap;

  const CardListItem({
    Key key,
    this.onTap,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).canvasColor,
      elevation: 1.0,
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(5.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              if (leading != null) leading,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (title != null)
                      DefaultTextStyle(
                        child: title,
                        style: Theme.of(context).textTheme.title,
                      ),
                    if (subtitle != null)
                      DefaultTextStyle(
                        child: subtitle,
                        style: Theme.of(context).textTheme.body1,
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }
}
