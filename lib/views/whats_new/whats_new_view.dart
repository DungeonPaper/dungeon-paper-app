import 'package:dungeon_paper/widget_utils.dart';

import '../../components/standard_dialog_controls.dart';
import '../../utils.dart';
import '../../version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsNew extends StatefulWidget {
  final Widget Function(BuildContext context, Widget child) builder;

  const WhatsNew({
    Key key,
    this.builder,
  }) : super(key: key);

  WhatsNew.withScaffold({
    Key key,
  })  : builder = scaffoldBuilder,
        super(key: key);

  WhatsNew.dialog({
    Key key,
  })  : builder = dialogBuilder,
        super(key: key);

  static Widget dialogBuilder(BuildContext context, Widget child) {
    return SimpleDialog(
      title: Text("What's New?"),
      contentPadding: EdgeInsets.only(bottom: 8),
      titlePadding: EdgeInsets.all(16).copyWith(bottom: 0),
      children: <Widget>[
        child,
        StandardDialogControls(
          onOK: () => Navigator.pop(context),
          okText: Text('Got it!'),
        )
      ],
    );
  }

  static Widget scaffoldBuilder(BuildContext context, Widget child) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text("What's New?"),
      ),
      body: SingleChildScrollView(child: child),
    );
  }

  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  Map<SemVer, String> changelog;
  String changelogUrl;
  SemVer currentVersion;

  @override
  void initState() {
    _initChangelog();
    _getCurrentVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (currentVersion == null ||
        changelog == null ||
        changelog[currentVersion] == null)
      child = Container(
        width: 150,
        height: 150,
        child: Center(child: PageLoader()),
      );
    else
      child = Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: MarkdownBody(
              data: mapped(currentVersion),
              onTapLink: (url) => launch(url),
            ),
          ),
        ],
      );

    if (widget.builder != null) return widget.builder(context, child);
    return child;
  }

  String mapped(SemVer ver) {
    if (changelog == null) return "";
    if (changelog[ver] == null) ver = changelog.keys.firstWhere((k) => k <= ver);
    var keys = changelog.keys;
    var verIdx = keys.toList().indexOf(ver);
    SemVer prevVersion;
    if (verIdx < keys.length - 1) prevVersion = keys.elementAt(verIdx + 1);
    List<SemVer> versions = [
      ver,
      if (prevVersion != null) prevVersion,
    ];
    return versions.map(_verString).toList().join('\n');
  }

  String _verString(SemVer v) {
    String prefix = v == currentVersion ? '' : 'Previous ';
    return "## ${prefix}Version $v\n\n" + changelog[v];
  }

  void _initChangelog() async {
    await _getSecrets();
    await _getChangelog();
  }

  void _getCurrentVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      currentVersion = SemVer.from(packageInfo.version);
    });
  }

  Future<void> _getSecrets() async {
    Map<String, dynamic> secrets = await loadSecrets();
    changelogUrl = secrets['GITHUB_CHANGELOG_URL'];
  }

  Future<void> _getChangelog() async {
    var client = http.Client();
    var res = await client.post(Uri.parse(changelogUrl));
    setState(() {
      changelog = ChangelogParser.parseString(res.body);
    });
  }
}
