import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<HomeNavBar> createState() => _CharacterHomeNavBarState();
}

class _CharacterHomeNavBarState extends State<HomeNavBar> {
  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_refreshState);
  }

  void _refreshState() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_refreshState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.pageController.positions.length == 1 ? widget.pageController.page?.round() ?? 1 : 1;

    final items = <String, Icon>{
      S.current.navActions: const Icon(DwIcons.hand_rock),
      S.current.navCharacter: const Icon(Icons.person),
      S.current.navJournal: const Icon(DwIcons.scroll_quill),
    };

    return Material(
      type: MaterialType.canvas,
      child: SizedBox(
        height: 70,
        child: InkWell(
          splashColor: Theme.of(context).splashColor,
          hoverColor: Colors.transparent,
          // ignore: avoid_returning_null_for_void
          onTap: () => null,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: enumerate(items.keys)
                      .map(
                        (item) => _NavItem(
                          icon: items[item.value]!,
                          label: item.value,
                          selected: currentIndex == item.index,
                          onTap: () => widget.pageController.animateToPage(
                            item.index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutQuad,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final selectedColor = colorScheme.secondary;
    final selectedFgColor = theme.colorScheme.onSecondary;
    final unselectedFgColor = theme.colorScheme.onSurface;
    const duration = Duration(milliseconds: 250);

    return Listener(
      onPointerDown: (_) => onTap(),
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipPath(
              clipper: const ShapeBorderClipper(shape: StadiumBorder()),
              child: AnimatedContainer(
                duration: duration,
                width: selected ? 60 : 40,
                color: selected ? selectedColor : Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: IconTheme(
                    data: IconThemeData(
                      color: selected ? selectedFgColor : unselectedFgColor,
                    ),
                    child: icon,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: duration,
              style: theme.textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: selected ? selectedColor : null,
              ),
              child: Text(
                label,
                textScaler: const TextScaler.linear(1.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
