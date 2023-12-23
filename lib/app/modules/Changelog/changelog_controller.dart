import 'package:dungeon_paper/app/modules/Changelog/changelog_parser.dart';
import 'package:dungeon_paper/core/http/api_base.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

const changelogUrl = 'https://dungeonpaper.app/CHANGELOG.md';

class ChangelogController extends ChangeNotifier {
  List<ChangelogEntry> _entries = [];
  late final Version currentVersion;
  final api = ApiBase();
  bool loading = false;

  ChangelogController() {
    getAppVersion();
    fetchChangelog();
  }

  List<ChangelogEntry> get entries => _entries;

  void parseChangelog(String changelog) {
    _entries = ChangelogParser(changelog).entries;
    debugPrint('Parsed ${_entries.length} entries');
    notifyListeners();
  }

  Future<String> getRawChangelog() async {
    final resp = await api.get(changelogUrl);
    return resp.body;
  }

  Future<void> fetchChangelog() async {
    loading = true;
    notifyListeners();
    debugPrint('Fetching changelog from $changelogUrl');
    final changelog = await getRawChangelog();
    parseChangelog(changelog);
    debugPrint('Changelog fetched, ${_entries.length} entries');
    loading = false;
    notifyListeners();
  }

  Future<void> getAppVersion() async {
    final resp = await PackageInfo.fromPlatform();
    final version = Version.parse('2.0.2');
    // final version = Version.parse(resp.version);
    currentVersion = version;
  }
}

