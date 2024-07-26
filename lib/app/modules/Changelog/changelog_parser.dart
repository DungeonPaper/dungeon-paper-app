import 'package:pub_semver/pub_semver.dart';

class ChangelogParser {
  late final List<ChangelogEntry> _entries;

  ChangelogParser(String raw) {
    _entries = raw
        .split(RegExp(r'\n(?=#)'))
        .map((e) => ChangelogEntry.parse(e))
        .toList();
  }

  List<ChangelogEntry> get entries => _entries;

  ChangelogEntry get latest => _entries.first;
}

class ChangelogEntry {
  final Version version;
  final String content;

  ChangelogEntry._(this.version, this.content);
  ChangelogEntry.unreleased(this.version)
      : content = 'The version you are using has no changelog entry.';

  factory ChangelogEntry.parse(String raw) {
    final lines = raw.split('\n');
    final version =
        Version.parse(lines.first.replaceAll(RegExp(r'^(#+\s)*'), ''));
    final content = lines.skip(1).join('\n');
    return ChangelogEntry._(version, content);
  }
}
