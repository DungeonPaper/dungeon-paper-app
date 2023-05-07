import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:flutter/material.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({
    super.key,
    required this.themes,
    this.selected,
    required this.onSelected,
  });

  final List<int> themes;
  final int? selected;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (final theme in themes)
          _ThemePreview(
            theme: theme,
            selected: theme == selected,
            onTap: () => onSelected(theme),
          ),
      ],
    );
  }
}

// _ThemePreview stateless widget
class _ThemePreview extends StatelessWidget {
  const _ThemePreview({
    // ignore: unused_element
    super.key,
    required this.theme,
    required this.selected,
    required this.onTap,
  });

  final int theme;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = AppThemes.getTheme(theme);
    const size = 80.0;
    final textDirection = Directionality.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      width: size + 24,
      child: Column(
        children: [
          SizedBox(
            height: size + 8,
            width: size + 8,
            child: Material(
              shape: rRectShape.copyWith(borderRadius: rRectShape.borderRadius / 2),
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Material(
                  shape: rRectShape.copyWith(borderRadius: rRectShape.borderRadius / 2),
                  color: themeData.scaffoldBackgroundColor,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: onTap,
                    child: Stack(
                      children: [
                        Positioned.directional(
                          textDirection: textDirection,
                          bottom: 0,
                          start: 0,
                          end: 0,
                          child: Container(
                            color: themeData.canvasColor,
                            height: 20,
                          ),
                        ),
                        Positioned.directional(
                          textDirection: textDirection,
                          bottom: 6,
                          start: 0,
                          end: 0,
                          child: Center(
                            child: Container(
                              width: size * 0.2,
                              height: 8,
                              decoration: BoxDecoration(
                                color: themeData.colorScheme.secondary,
                                borderRadius: borderRadius / 4,
                              ),
                            ),
                          ),
                        ),
                        // Card
                        Positioned.directional(
                          textDirection: textDirection,
                          top: 2,
                          start: 8,
                          end: 8,
                          child: SizedBox(
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 1,
                              color: themeData.cardColor,
                              shape: rRectShape.copyWith(borderRadius: rRectShape.borderRadius / 2),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0).copyWith(top: 22),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Material(
                                      elevation: 5,
                                      type: MaterialType.circle,
                                      color: themeData.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (selected)
                          Positioned.directional(
                            textDirection: textDirection,
                            end: 6,
                            bottom: 6,
                            child: const Material(
                              type: MaterialType.circle,
                              child: Padding(
                                padding: EdgeInsets.all(3),
                                child: Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              color: DwColors.success,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(
            AppThemes.getThemeName(theme),
            overflow: TextOverflow.fade,
            maxLines: 2,
            textAlign: TextAlign.center,
            textScaleFactor: 0.75,
          ),
        ],
      ),
    );
  }
}
