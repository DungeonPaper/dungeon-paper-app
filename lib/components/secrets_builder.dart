import 'package:flutter/material.dart';
import '../flutter_utils/flutter_utils.dart';
import '../utils.dart';

class SecretsBuilder extends StatefulWidget {
  final Widget loader;
  final CallbackDelegate<Secrets, Widget> builder;

  const SecretsBuilder({
    Key key,
    this.loader,
    @required this.builder,
  }) : super(key: key);

  @override
  _SecretsBuilderState createState() => _SecretsBuilderState();
}

class _SecretsBuilderState extends State<SecretsBuilder> {
  Secrets secrets;

  @override
  initState() {
    super.initState();
    _getSecrets();
  }

  _getSecrets() async {
    Secrets loaded = await loadSecrets();
    if (this.mounted) {
      setState(() {
        secrets = loaded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (secrets == null) return widget.loader ?? Container();
    return widget.builder(secrets);
  }
}
