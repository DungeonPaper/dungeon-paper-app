import '../../components/hyperlink.dart';
import '../../redux/stores/stores.dart';
import '../../utils.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackButton extends StatefulWidget {
  final void Function() onPressed;
  final bool dontWaitForUser;
  final Widget Function(Function() onPressed, String mailtoUrl) builder;
  final Widget icon;
  final String labelText;
  static const Icon feedbackIcon = Icon(Icons.feedback);
  static const feedbackLabel = 'Send Feedback';

  const FeedbackButton({
    Key key,
    @required this.builder,
    this.icon = feedbackIcon,
    this.labelText = feedbackLabel,
    this.onPressed,
    this.dontWaitForUser = false,
  }) : super(key: key);

  factory FeedbackButton.iconButton({
    Key key,
    Widget icon = feedbackIcon,
    String labelText = feedbackLabel,
    Function() onPressed,
    bool dontWaitForUser = false,
  }) =>
      FeedbackButton(
        key: key,
        onPressed: onPressed,
        dontWaitForUser: dontWaitForUser,
        builder: (onPressed, _) => IconButton(
          icon: icon,
          tooltip: labelText,
          onPressed: onPressed,
        ),
      );

  factory FeedbackButton.raisedButton({
    Key key,
    Widget icon = feedbackIcon,
    String labelText = feedbackLabel,
    Function() onPressed,
    bool dontWaitForUser = false,
  }) =>
      FeedbackButton(
        key: key,
        onPressed: onPressed,
        dontWaitForUser: dontWaitForUser,
        builder: (onPressed, _) => RaisedButton(
          child: Column(
            children: <Widget>[icon, Expanded(child: Text(labelText))],
          ),
          onPressed: onPressed,
        ),
      );

  factory FeedbackButton.listItem({
    Key key,
    Widget icon = feedbackIcon,
    String labelText = feedbackLabel,
    Function() onPressed,
    bool dontWaitForUser = false,
  }) =>
      FeedbackButton(
        key: key,
        onPressed: onPressed,
        dontWaitForUser: dontWaitForUser,
        builder: (onPressed, _) => ListTile(
          leading: icon,
          title: Text(labelText),
          onTap: onPressed,
        ),
      );

  factory FeedbackButton.hyperlink({
    Key key,
    String labelText = feedbackLabel,
    Function() onPressed,
    bool dontWaitForUser = false,
  }) =>
      FeedbackButton(
        key: key,
        onPressed: onPressed,
        dontWaitForUser: dontWaitForUser,
        builder: (_, mailtoUrl) => Hyperlink(text: labelText, url: mailtoUrl),
      );

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
    if (this.mounted) {
      setState(() {
        userId = dwStore.state.user.currentUserDocID;
      });
    }
  }

  _getEmail() async {
    var secrets = await loadSecrets();
    if (this.mounted) {
      setState(() {
        email = secrets['FEEDBACK_EMAIL'];
      });
    }
  }

  _getVersionData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (this.mounted) {
      setState(() {
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    }
  }

  String get subject => Uri.encodeComponent('Dungeon Paper feedback');
  String get body => Uri.encodeComponent("""\n\n\n\n
    --- PACKAGE INFO ---\n
    Version: $version\n
    Build Number: $buildNumber\n
    User ID: ${userId ?? 'Unavailable'}\n
    """);
  // '\n\n\n\n\n--- PACKAGE INFO ---\nVersion: $version\nBuild Number: $buildNumber\nUser ID: ${userId ?? 'Unavailable'}');
  String get mailtoUrl => 'mailto:$email?subject=$subject&body=$body';
  void sendEmail() => launch(mailtoUrl);
  void onPressed() {
    sendEmail();
    if (widget.onPressed != null) widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    if ([widget.dontWaitForUser ? true : userId, email, version]
        .any((i) => i == null)) return Container();
    return widget.builder(onPressed, mailtoUrl);
  }
}
