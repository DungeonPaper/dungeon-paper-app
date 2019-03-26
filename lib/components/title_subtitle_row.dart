import 'package:flutter/material.dart';

class TitleSubtitleRow extends StatelessWidget {
  const TitleSubtitleRow({
    Key key,
    @required this.title,
    @required this.subtitle,
    this.contentPadding,
  }) : super(key: key);

  final Widget title;
  final Widget subtitle;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    List<Widget> children = [];
    if (title != null) {
      children.add(DefaultTextStyle(
        child: title,
        style: textTheme.title,
      ));
    }
    if (subtitle != null) {
      children.add(DefaultTextStyle(
        child: subtitle,
        style: textTheme.body1,
      ));
    }

    return Container(
      padding: contentPadding ?? const EdgeInsets.symmetric(vertical: 16.0),
      child: children.length == 1
          ? children.first
          : children.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                )
              : SizedBox.shrink(),
    );
  }
}

class TitleSubtitleCard extends StatelessWidget {
  final void Function() onTap;
  final Widget title;
  final Widget subtitle;
  final Widget child;
  final Widget leading;
  final Widget trailing;
  final Color color;

  const TitleSubtitleCard({
    Key key,
    this.onTap,
    this.title,
    this.subtitle,
    this.child,
    this.leading,
    this.trailing,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget top = TitleSubtitleRow(
      title: title,
      subtitle: subtitle,
    );
    Widget content = child == null
        ? top
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[top, child],
          );
    return Material(
      borderRadius: BorderRadius.circular(5),
      type: MaterialType.card,
      elevation: 1.0,
      color: color ?? Theme.of(context).canvasColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(
            left: leading != null ? 8.0 : 16.0,
            right: trailing != null ? 8.0 : 16.0,
          ),
          child: contentLayout(content),
        ),
      ),
    );
  }

  Widget contentLayout(Widget content) {
    if (leading == null && trailing == null) {
      return content;
    }

    List<Widget> children = [Expanded(child: content)];

    if (leading != null) {
      children.insert(
          0,
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: leading,
          ));
    }
    if (trailing != null) {
      children.add(trailing);
    }

    return Row(children: children);
  }
}
