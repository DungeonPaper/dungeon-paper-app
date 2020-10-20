import 'package:dungeon_paper/src/atoms/card_list_item.dart';
import 'package:dungeon_paper/src/pages/custom_classes_view/custom_classes_view.dart';
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
        automaticallyImplyLeading: true,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              CardListItem(
                title: Text('Custom Classes'),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<bool>(
                      fullscreenDialog: true,
                      builder: (context) => CustomClassesView(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
