import 'package:flutter/material.dart';

import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:provider/provider.dart';

import '{{snakeCase name}}_controller.dart';

class {{pascalCase name}}View extends StatelessWidget
    with CharacterProviderMixin, UserProviderMixin {
  const {{pascalCase name}}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('{{startCase name}}'),
        centerTitle: true,
      ),
      body: Consumer<{{pascalCase name}}Controller>(
        builder: (context, ctrl, _) => const Center(
          child: Text('{{startCase name}} Content'),
        ),
      ),
    );
  }
}

