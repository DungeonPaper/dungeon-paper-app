import 'package:pub_semver/pub_semver.dart';

class ChangelogParser {
  String changelog;
  Map<Version, List<String>> _parsed;

  ChangelogParser({
    this.changelog,
  });

  static Map<Version, String> parseString(String changelog) {
    Map<Version, String> output = {};
    Version cur;
    for (String line in changelog.split('\n')) {
      if (line.trim().startsWith(RegExp('#\b')) || line.trim() == "") continue;

      // version number line
      if (RegExp('##').matchAsPrefix(line.trim()) != null) {
        final String lineWithoutPrefix = line.substring(2).trim();
        final String versionStringMatch =
            RegExp('([0-9]+\.){2}[0-9]+').stringMatch(lineWithoutPrefix);
        cur = Version.parse(versionStringMatch);
        continue;
      }

      // message line
      // if (RegExp('\\*\s*').matchAsPrefix(line.trim()) != null) {
      String message = line; // .trim().substring(1).trim();
      if (cur != null) {
        if (!output.containsKey(cur)) output[cur] = "";
        output[cur] += "$message\n";
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
