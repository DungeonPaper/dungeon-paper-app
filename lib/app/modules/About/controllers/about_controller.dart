import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

class AboutController extends ChangeNotifier {
  Version? version;

  AboutController() {
    getVersion();
  }

  Future<void> getVersion() async {
    final info = await PackageInfo.fromPlatform();
    version = Version.parse('${info.version}+${info.buildNumber}');
    notifyListeners();
  }
}
