import 'package:dungeon_paper/src/pages/backup_view/backup_view.dart';
import 'package:dungeon_paper/src/pages/settings_view/settings_list_tile.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/prefs_settings.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/prefs_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/scaffolds/scaffold_with_elevation.dart';
import 'package:dungeon_paper/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithElevation(
      title: Text('Dungeon Paper Settings'),
      body: DWStoreConnector<PrefsSettings>(
          converter: (state) => state.state.prefs.settings,
          builder: (context, settings) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16).copyWith(top: 0),
                child: Material(
                  shape: RoundedRectangleBorder(borderRadius: cardRadius),
                  color: Theme.of(context).canvasColor,
                  child: Column(
                    children: [
                      SettingsListTile(
                        title: Text('Backup Data'),
                        subtitle: Text(
                            'Import & export characters and custom classes.\nYou can share these files with other users safely.'),
                        onTap: () => Get.to(BackupView()),
                      ),
                      Divider(
                        height: 1,
                      ),
                      CheckboxSettingsListTile(
                        title: Text('Keep screen on'),
                        subtitle: Text(
                          'When checked, your screen will be prevented from turning off while the app is in the foreground.',
                        ),
                        value: settings.keepScreenOn,
                        onChanged: (value) {
                          dwStore.dispatch(
                            ChangeSetting<bool>(
                              name: SettingName.keepScreenOn,
                              value: value,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
