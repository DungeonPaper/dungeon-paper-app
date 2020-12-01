import 'package:flutter/material.dart';

const _defaultContentPadding = EdgeInsets.all(16);

class SettingsListTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget leading;
  final Widget trailing;
  final void Function() onTap;
  final bool dense;
  final bool isThreeLine;
  final EdgeInsets contentPadding;

  const SettingsListTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.dense = false,
    this.isThreeLine = false,
    this.onTap,
    this.contentPadding = _defaultContentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      dense: dense,
      isThreeLine: isThreeLine,
      contentPadding: contentPadding,
    );
  }
}

class CheckboxSettingsListTile extends StatelessWidget {
  final bool value;
  final Widget title;
  final Widget subtitle;
  final void Function(bool) onChanged;
  final bool dense;
  final bool isThreeLine;
  final EdgeInsets contentPadding;

  const CheckboxSettingsListTile({
    Key key,
    @required this.value,
    @required this.title,
    @required this.onChanged,
    this.subtitle,
    this.dense = false,
    this.isThreeLine = false,
    this.contentPadding = _defaultContentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: title,
      subtitle: subtitle,
      onChanged: onChanged,
      value: value,
      dense: dense,
      isThreeLine: isThreeLine,
      contentPadding: contentPadding,
    );
  }
}
