import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

enum FeedbackButtonType { IconButton, RaisedButton, ListItem }

class FeedbackButton extends StatefulWidget {
  final FeedbackButtonType type;
  final void Function() onPressed;

  const FeedbackButton({Key key, @required this.type, this.onPressed})
      : super(key: key);

  const FeedbackButton.iconButton({Key key, this.onPressed})
      : type = FeedbackButtonType.IconButton,
        super(key: key);

  const FeedbackButton.raisedButton({Key key, this.onPressed})
      : type = FeedbackButtonType.RaisedButton,
        super(key: key);

  const FeedbackButton.listItem({Key key, this.onPressed})
      : type = FeedbackButtonType.ListItem,
        super(key: key);
  @override
  _FeedbackButtonState createState() => _FeedbackButtonState();
}

class _FeedbackButtonState extends State<FeedbackButton> {
  String email;
  String version;
  String buildNumber;

  final Widget icon = Icon(Icons.feedback);
  final String labelText = 'Send Feedback';

  @override
  void initState() {
    _getEmail();
    _getVersionData();
    super.initState();
  }

  _getEmail() async {
    var secrets = await loadSecrets();
    setState(() {
      email = secrets['FEEDBACK_EMAIL'];
    });
  }

  _getVersionData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  String get subject => Uri.encodeComponent('Dungeon Paper feedback');
  String get body => Uri.encodeComponent(
      '\n\n\n\n\n--- PACKAGE INFO ---\nVersion: $version\nBuild Number: $buildNumber');
  void sendEmail() => launch('mailto:$email?subject=$subject&body=$body');
  void onPressed() {
    sendEmail();
    if (widget.onPressed != null) widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    if (![email, version].every((i) => i != null)) return Container();
    if (widget.type == FeedbackButtonType.IconButton)
      return IconButton(
        icon: icon,
        tooltip: labelText,
        onPressed: onPressed,
      );
    if (widget.type == FeedbackButtonType.ListItem)
      return ListTile(
        leading: icon,
        title: Text(labelText),
        onTap: onPressed,
      );
    return RaisedButton(
      child: Column(
        children: <Widget>[icon, Expanded(child: Text(labelText))],
      ),
      onPressed: onPressed,
    );
  }
}
