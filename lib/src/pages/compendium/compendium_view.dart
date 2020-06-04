import 'package:dungeon_paper/src/lists/custom_classes_list.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Compendium extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<DWStore>(
      store: dwStore,
      child: ScaffoldWithElevation(
        title: Text('Compendium'),
        body: CustomClassesList(),
      ),
    );
  }
}
