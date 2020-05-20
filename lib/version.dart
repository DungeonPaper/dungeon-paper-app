import 'package:pub_semver/pub_semver.dart';

class ChangelogParser {
  String changelog;
  Map<Version, List<String>> _parsed;

  ChangelogParser({
    this.changelog,
  });

  static Map<Version, ChangelogContent> parseString(String changelog) {
    Map<Version, ChangelogContent> output = {};
    Version cur;
    for (String line in changelog.split('\n')) {
      if (line.trim().startsWith(RegExp('#\b')) || line.trim() == "") continue;

      // version number line
      if (RegExp('##').matchAsPrefix(line.trim()) != null) {
        final String lineWithoutPrefix = line.substring(2).trim();
        final String versionStringMatch =
            RegExp('([0-9]+\.){2}[0-9]+').stringMatch(lineWithoutPrefix);
        cur = Version.parse(versionStringMatch);
        if (!output.containsKey(cur)) {
          output[cur] = ChangelogContent(cur, title: lineWithoutPrefix);
        }
        continue;
      }

      // message line
      // if (RegExp('\\*\s*').matchAsPrefix(line.trim()) != null) {
      String message = line; // .trim().substring(1).trim();
      if (cur != null) {
        output[cur].lines.add("$message");
        continue;
      }
      // }
    }

    return output;
  }

  parse() => parseString(changelog);

  Map<Version, List<String>> get parsed =>
      _parsed != null ? _parsed : _parsed = parse();
}

class ChangelogContent {
  final Version version;
  final List<String> lines;
  String title;
  ChangelogContent(
    this.version, {
    String title,
    List<String> lines,
  })  : this.title = title ?? version.toString(),
        this.lines = lines ?? [];
}
