import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardListItem extends StatelessWidget {
  final void Function() onTap;
  final Widget title;
  final Widget subtitle;
  final Widget child;
  final Widget leading;
  final Widget trailing;
  final Color color;
  final double elevation;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double width;

  const CardListItem({
    Key key,
    this.onTap,
    this.title,
    this.subtitle,
    this.child,
    this.leading,
    this.trailing,
    this.color,
    this.elevation = 1.0,
    this.margin,
    this.width,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget top = TitleSubtitleRow(
      title: title,
      subtitle: subtitle,
    );
    var content = child == null
        ? top
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[top, child],
          );
    var finalContent = Container(
      width: width,
      padding: padding ??
          EdgeInsets.only(
            left: leading != null ? 8.0 : 16.0,
            right: trailing != null ? 8.0 : 16.0,
          ),
      child: contentLayout(content),
    );
    return Card(
      margin: margin,
      elevation: elevation,
      color: color ?? Get.theme.canvasColor,
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              child: finalContent,
            )
          : finalContent,
    );
  }

  Widget contentLayout(Widget content) {
    if (leading == null && trailing == null) {
      return content;
    }

    return Row(children: [
      if (leading != null)
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: leading,
        ),
      Expanded(child: content),
      if (trailing != null) trailing,
    ]);
  }
}

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
    var theme = Get.theme;
    var textTheme = theme.textTheme;
    var children = <Widget>[
      if (title != null)
        DefaultTextStyle(
          child: title,
          style: textTheme.headline6,
        ),
      if (subtitle != null)
        DefaultTextStyle(
          child: subtitle,
          style: textTheme.bodyText2,
        )
    ];

    return Container(
      padding: contentPadding ?? const EdgeInsets.symmetric(vertical: 16.0),
      child: children.length == 1
          ? children.first
          : children.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                )
              : SizedBox.shrink(),
    );
  }
}
