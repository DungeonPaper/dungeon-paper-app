import 'package:dungeon_paper/db/models/custom_class.dart';
import 'package:dungeon_paper/src/atoms/empty_state.dart';
import 'package:dungeon_paper/src/dialogs/confirmation_dialog.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/lists/custom_classes_list.dart';
import 'package:dungeon_paper/src/lists/player_class_list.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/scaffolds/custom_class_wizard/custom_class_wizard.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedantic/pedantic.dart';

class CustomClassesView extends StatefulWidget {
  @override
  _CustomClassesViewState createState() => _CustomClassesViewState();
}

class _CustomClassesViewState extends State<CustomClassesView> {
  @override
  void initState() {
    super.initState();
    logger.d('Page View: ${ScreenNames.CustomClasses}');
    analytics.setCurrentScreen(screenName: ScreenNames.CustomClasses);
  }

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<bool>(
      converter: (store) =>
          store.state.customClasses.customClasses?.isNotEmpty == true,
      builder: (context, hasClasses) {
        return ScaffoldWithElevation(
          title: Text('Custom Classes'),
          automaticallyImplyLeading: true,
          useElevation: false,
          elevation: 0,
          actions: [
            PlayerClassList(
              builder: (context, list) => PopupMenuButton<PlayerClass>(
                icon: Icon(Icons.content_copy),
                tooltip: 'Copy existing class',
                onSelected: _copyExisting,
                itemBuilder: (context) => [
                  PopupMenuItem<PlayerClass>(
                    value: null,
                    enabled: false,
                    child: Text('Copy existing class:'),
                  ),
                  ...list.map(
                    (el) => PopupMenuItem<PlayerClass>(
                      value: el,
                      child: Text(el.name),
                    ),
                  ),
                ],
              ),
            ),
          ],
          wrapWithScrollable: hasClasses,
          body: hasClasses
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomClassesList(
                    onEdit: _edit(context),
                    onDelete: _delete(context),
                  ),
                )
              : Center(
                  child: EmptyState(
                    title: Text('You have no custom classes'),
                    subtitle: Text("Start by tapping the '+' button"),
                    image: Icon(Icons.person, size: 80),
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Theme.of(context).colorScheme.background,
            foregroundColor: Theme.of(context).colorScheme.onBackground,
            onPressed: _add(context),
          ),
        );
      },
    );
  }

  void Function() _add(BuildContext context) {
    return () {
      Get.to(CustomClassWizard(mode: DialogMode.Create));
    };
  }

  void Function(CustomClass) _edit(BuildContext context) {
    return (cls) {
      Get.to(
        CustomClassWizard(
          mode: DialogMode.Edit,
          customClass: cls,
          onSave: _save,
        ),
      );
    };
  }

  void _save(CustomClass _cls) async {
    for (var char in dwStore.state.characters.characters.values) {
      if (char.playerClasses.any((el) => el.key == _cls.key)) {
        var _updated = char.playerClasses
            .map((el) => el.key == _cls.key ? _cls.toPlayerClass() : el)
            .toList();
        char.playerClasses = _updated;
        await char.update();
      }
    }
  }

  Future<void> Function(CustomClass) _delete(BuildContext context) {
    return (cls) async {
      if (await showDialog(
            context: context,
            builder: (context) => ConfirmationDialog(
              title: Text('Are you sure you want to delete this class?'),
              text: Text(
                  "Don't worry, your characters using this class wil not be affected."),
            ),
          ) ==
          true) {
        unawaited(cls.delete());
      }
    };
  }

  void _copyExisting(PlayerClass cls) {
    var custCls = CustomClass.fromPlayerClass(cls);
    custCls.name = custCls.name + ' copy';

    Get.to(
      CustomClassWizard(
        mode: DialogMode.Create,
        customClass: custCls,
      ),
    );
  }
}
