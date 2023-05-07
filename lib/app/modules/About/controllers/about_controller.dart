import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

class AboutController extends GetxController {
  final version = Rx<Version?>(null);

  @override
  void onInit() {
    super.onInit();
    getVersion();
  }

  Future<void> getVersion() async {
    final info = await PackageInfo.fromPlatform();
    version.value = Version.parse(info.version + '+' + info.buildNumber);
  }
}
