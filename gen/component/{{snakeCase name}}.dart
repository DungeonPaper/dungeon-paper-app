import 'package:flutter/material.dart';

import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:provider/provider.dart';

class {{pascalCase name}} extends StatelessWidget with UserProviderMixin, CharacterProviderMixin {
  const {{pascalCase name}}({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('{{startCase name}}');
  }
}

