import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';

class VersionNumber extends StatefulWidget {
  final Widget Function(String version) builder;

  const VersionNumber({
    Key key,
    @required this.builder,
  }) : super(key: key);

  factory VersionNumber.text({Key key, String prefix, String suffix}) =>
      VersionNumber(
        key: key,
        builder: (v) =>
            Text([prefix, v, suffix].where((s) => s != null).join(' ')),
      );

  @override
  _VersionNumberState createState() => _VersionNumberState();
}

class _VersionNumberState extends State<VersionNumber> {
  String version;

  @override
  void initState() {
    _getVersion();
    super.initState();
  }

  void _getVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();

    if (mounted) {
      setState(() {
        version = packageInfo.version;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(version ?? '...');
  }
}
