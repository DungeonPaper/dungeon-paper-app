import 'package:dungeon_paper/src/utils/types.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';

class SecretsLoader extends StatefulWidget {
  final Widget loader;
  final CallbackDelegate<Secrets, Widget> builder;

  const SecretsLoader({
    Key key,
    this.loader,
    @required this.builder,
  }) : super(key: key);

  @override
  _SecretsLoaderState createState() => _SecretsLoaderState();
}

class _SecretsLoaderState extends State<SecretsLoader> {
  Secrets secrets;

  @override
  initState() {
    super.initState();
    _getSecrets();
  }

  _getSecrets() async {
    var loaded = await loadSecrets();
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
