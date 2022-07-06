import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({
    super.key,
    required this.themes,
    required this.selected,
    required this.onSelected,
  });

  final List<int> themes;
  final int selected;
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
    final ctxTheme = Theme.of(context);
    final ctxTextTheme = ctxTheme.textTheme;
    final ctxColorScheme = ctxTheme.colorScheme;
    final bodySmall = ctxTextTheme.bodySmall!;
    final themeData = AppThemes.getTheme(theme);
    const size = 80.0;
    final textDirection = Directionality.of(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: size,
        height: size,
        child: Material(
          shape: rRectShape.copyWith(borderRadius: rRectShape.borderRadius / 2),
          color: selected ? ctxColorScheme.secondary : Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(2),
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
                        // child: Padding(
                        //   padding: const EdgeInsets.all(4).copyWith(bottom: 6),
                        //   child: Text(
                        //     AppThemes.getThemeName(theme),
                        //     style: bodySmall.copyWith(color: ctxColorScheme.onSurface),
                        //     textScaleFactor: 0.9,
                        //   ),
                        // ),
                      ),
                    ),
                    Positioned.directional(
                      textDirection: textDirection,
                      bottom: 6,
                      start: 32,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: size * 0.2,
                              height: 8,
                              decoration: BoxDecoration(
                                color: themeData.colorScheme.secondary,
                                borderRadius: borderRadius / 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.directional(
                      textDirection: textDirection,
                      bottom: 26,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
