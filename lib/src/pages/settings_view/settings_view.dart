import 'package:dungeon_paper/src/pages/backup_view/backup_view.dart';
import 'package:dungeon_paper/src/pages/settings_view/settings_list_tile.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/prefs_settings.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/prefs_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/scaffolds/main_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: Text('Dungeon Paper Settings'),
      body: DWStoreConnector<PrefsSettings>(
          converter: (state) => state.state.prefs.settings,
          builder: (context, settings) {
            final divider = Divider(height: 1);

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16).copyWith(top: 0),
                child: Card(
                  child: Column(
                    children: [
                      SettingsListTile(
                        title: Text('Backup Data'),
                        subtitle: Text(
                            'Import & export characters and custom classes.\nYou can share these files with other users safely.'),
                        onTap: _openBackupView,
                      ),
                      // divider,
                      // SettingsListTile(
                      //   title: Text('Theme'),
                      //   subtitle: Text(
                      //       'Choose the color scheme of the app interface. '
                      //       'Current: {placeholder}'),
                      //   onTap: () => Get.to(ThemeSelectView()),
                      // ),
                      divider,
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

  void _openBackupView() => Get.to(BackupView());
}
