import 'dart:developer';

import 'package:dungeon_paper/components/standard_dialog_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';

import '../../version.dart';

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
  Map<SemVer, List<String>> changelog;
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
      child = Container();
    else
      child = Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: MarkdownBody(
              data: mapped(currentVersion),
            ),
          ),
        ],
      );

    if (widget.builder != null) return widget.builder(context, child);
    return child;
  }

  String mapped(SemVer ver) {
    if (changelog == null || changelog[ver] == null) return "";
    return "## Version $ver\n\n" + changelog[ver].map((s) => '* $s').join('\n');
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
    var res = await http.get(changelogUrl);
    setState(() {
      changelog = ChangelogParser.parseString(res.body);
    });
  }
}
