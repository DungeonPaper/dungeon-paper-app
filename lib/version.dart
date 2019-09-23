import 'package:meta/meta.dart';
import 'package:quiver_hashcode/hashcode.dart';

class SemVer {
  int major;
  int minor;
  int patch;

  SemVer(this.major, this.minor, this.patch);

  SemVer.ordered(this.major, this.minor, this.patch);

  SemVer.parse(String versionString) {
    var split = versionString.split('.').map((v) => int.parse(v)).toList();

    if (split.length != 3)
      throw ArgumentError.value(
          split.length, "versionString", "Version segment length invalid");

    major = split[0];
    minor = split[1];
    patch = split[2];
  }

  factory SemVer.from(dynamic version) {
    if (version is String) return SemVer.parse(version);
    if (version is SemVer) return version;

    throw ArgumentError.value(
        version.runtimeType, "version", "Cannot convert type to SemVer");
  }

  SemVer.named({
    @required this.major,
    @required this.minor,
    @required this.patch,
  });

  @override
  int get hashCode => hash3(major, minor, patch);

  bool operator ==(dynamic ver) {
    SemVer actual = SemVer.from(ver);
    return actual.major == major &&
        actual.minor == minor &&
        actual.patch == patch;
  }

  bool operator >(dynamic ver) {
    SemVer actual = SemVer.from(ver);
    if (major < actual.major || minor < actual.minor) return false;
    return major > actual.major || minor > actual.minor || patch > actual.patch;
  }

  bool operator <(dynamic ver) {
    SemVer actual = SemVer.from(ver);
    if (major > actual.major || minor > actual.minor) return false;
    return major < actual.major || minor < actual.minor || patch < actual.patch;
  }

  bool operator >=(dynamic ver) {
    return this == ver || this > ver;
  }

  bool operator <=(dynamic ver) {
    return this == ver || this < ver;
  }

  @override
  String toString() => "$major.$minor.$patch";
}

class ChangelogParser {
  String changelog;
  Map<SemVer, List<String>> _parsed;

  ChangelogParser({
    this.changelog,
  });

  static Map<SemVer, String> parseString(String changelog) {
    Map<SemVer, String> output = {};
    SemVer cur;
    for (String line in changelog.split('\n')) {
      if (line.trim().startsWith(RegExp('#\b')) || line.trim() == "") continue;

      // version number line
      if (RegExp('##').matchAsPrefix(line.trim()) != null) {
        final String lineWithoutPrefix = line.substring(2).trim();
        final String versionStringMatch =
            RegExp('([0-9]+\.){2}[0-9]+').stringMatch(lineWithoutPrefix);
        cur = SemVer.from(versionStringMatch);
        continue;
      }

      // message line
      // if (RegExp('\\*\s*').matchAsPrefix(line.trim()) != null) {
      String message = line; // .trim().substring(1).trim();
      if (!output.containsKey(cur)) output[cur] = "";
      output[cur] += message;
      continue;
      // }
    }

    return output;
  }

  parse() => parseString(changelog);

  Map<SemVer, List<String>> get parsed =>
      _parsed != null ? _parsed : _parsed = parse();
}
