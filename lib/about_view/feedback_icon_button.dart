import 'package:dungeon_paper/components/hyperlink.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

enum FeedbackButtonType { IconButton, RaisedButton, ListItem, Hyperlink }

class FeedbackButton extends StatefulWidget {
  final FeedbackButtonType type;
  final void Function() onPressed;
  final bool dontWaitForUser;

  const FeedbackButton({
    Key key,
    @required this.type,
    this.onPressed,
    this.dontWaitForUser = false,
  }) : super(key: key);

  const FeedbackButton.iconButton({
    Key key,
    this.onPressed,
    this.dontWaitForUser = false,
  })  : type = FeedbackButtonType.IconButton,
        super(key: key);

  const FeedbackButton.raisedButton({
    Key key,
    this.onPressed,
    this.dontWaitForUser = false,
  })  : type = FeedbackButtonType.RaisedButton,
        super(key: key);

  const FeedbackButton.listItem({
    Key key,
    this.onPressed,
    this.dontWaitForUser = false,
  })  : type = FeedbackButtonType.ListItem,
        super(key: key);

  const FeedbackButton.hyperlink({
    Key key,
    this.onPressed,
    this.dontWaitForUser = false,
  })  : type = FeedbackButtonType.Hyperlink,
        super(key: key);

  @override
  _FeedbackButtonState createState() => _FeedbackButtonState();
}

class _FeedbackButtonState extends State<FeedbackButton> {
  String userId;
  String email;
  String version;
  String buildNumber;

  final Widget icon = Icon(Icons.feedback);
  final String labelText = 'Send Feedback';

  @override
  void initState() {
    _getUserId();
    _getEmail();
    _getVersionData();
    super.initState();
  }

  _getUserId() async {
    setState(() {
      userId = dwStore.state.user.currentUserDocID;
    });
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
    """\n\n\n\n
    --- PACKAGE INFO ---
    Version: $version
    Build Number: $buildNumber
    User ID: ${userId ?? 'Unavailable'}
    """
  );
      // '\n\n\n\n\n--- PACKAGE INFO ---\nVersion: $version\nBuild Number: $buildNumber\nUser ID: ${userId ?? 'Unavailable'}');
  String get mailtoUrl => 'mailto:$email?subject=$subject&body=$body';
  void sendEmail() => launch(mailtoUrl);
  void onPressed() {
    sendEmail();
    if (widget.onPressed != null) widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    if (![widget.dontWaitForUser ? true : userId, email, version]
        .every((i) => i != null)) return Container();
    switch (widget.type) {
      case FeedbackButtonType.IconButton:
        return IconButton(
          icon: icon,
          tooltip: labelText,
          onPressed: onPressed,
        );
      case FeedbackButtonType.ListItem:
        return ListTile(
          leading: icon,
          title: Text(labelText),
          onTap: onPressed,
        );
      case FeedbackButtonType.Hyperlink:
        return Hyperlink(labelText, mailtoUrl);
      case FeedbackButtonType.RaisedButton:
      default:
        return RaisedButton(
          child: Column(
            children: <Widget>[icon, Expanded(child: Text(labelText))],
          ),
          onPressed: onPressed,
        );
    }
  }
}
