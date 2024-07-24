import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/user_provider.dart';

class {{pascalCase name}}Controller extends ChangeNotifier
    with CharacterProviderMixin, UserProviderMixin {
  final BuildContext context;
  {{pascalCase name}}Controller(this.context);

  static {{pascalCase name}}Controller of(BuildContext context) =>
      Provider.of<{{pascalCase name}}Controller>(context, listen: false);
}

