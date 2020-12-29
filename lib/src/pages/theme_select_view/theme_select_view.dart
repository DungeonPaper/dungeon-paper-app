import 'package:dungeon_paper/src/scaffolds/main_scaffold.dart';
import 'package:dungeon_paper/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeSelectView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: Text('Select Theme'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Choose a theme. Current: ${Themes.currentTheme}'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 10,
                  children: [
                    for (final theme in Themes.themes.values)
                      GetBuilder<Themes>(
                        builder: (themes) => _ThemePreviewCard(
                          name: theme.toString(),
                          theme: theme,
                          selected: themes.current == theme,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemePreviewCard extends StatelessWidget {
  final ThemeData theme;
  final String name;
  final bool selected;

  const _ThemePreviewCard({
    Key key,
    @required this.theme,
    @required this.name,
    @required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius:
            (Get.theme.cardTheme.shape as RoundedRectangleBorder).borderRadius,
        side: BorderSide(
          color: selected ? Colors.cyan[600] : Colors.transparent,
          width: selected ? 2 : 0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Get.changeTheme(theme);
          // Future.delayed(Duration(seconds: 1))
          //     .then((_) {
          Themes.changeTheme(theme);
          // });
        },
        child: SizedBox(
          height: 60,
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: theme.primaryColor,
                  child:
                      Text(name.substring(theme.runtimeType.toString().length)),
                ),
              ),
              Container(
                color: theme.accentColor,
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
