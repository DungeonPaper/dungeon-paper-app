import 'package:flutter/material.dart';
import '../flutter_utils.dart';
import '../utils.dart';

class SecretsLoader extends StatefulWidget {
  final Widget loader;
  final CallbackDelegate<Map<String, dynamic>, Widget> builder;

  const SecretsLoader({
    Key key,
    this.loader,
    @required this.builder,
  }) : super(key: key);

  @override
  _SecretsLoaderState createState() => _SecretsLoaderState();
}

class _SecretsLoaderState extends State<SecretsLoader> {
  Map<String, dynamic> secrets;

  @override
  initState() {
    super.initState();
    _getSecrets();
  }

  _getSecrets() async {
    Map<String, dynamic> loaded = await loadSecrets();
    if (this.mounted)
      setState(() {
        secrets = loaded;
      });
  }

  @override
  Widget build(BuildContext context) {
    if (secrets == null) return widget.loader ?? Container();
    return widget.builder(secrets);
  }
}
