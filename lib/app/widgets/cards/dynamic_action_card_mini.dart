import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

import '../../../core/dw_icons.dart';
import '../atoms/background_icon_button.dart';
import '../atoms/svg_icon.dart';

class DynamicActionCardMini extends StatelessWidget {
  const DynamicActionCardMini({
    Key? key,
    required this.title,
    required this.icon,
    required this.starred,
    this.showStar = true,
    this.starredIcon,
    this.unstarredIcon,
    required this.dice,
    required this.description,
    this.chips = const [],
    required this.onStarChanged,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Widget? icon;
  final Widget? starredIcon;
  final Widget? unstarredIcon;
  final bool starred;
  final bool showStar;
  final List<Dice> dice;
  final String description;
  final Iterable<Widget> chips;
  final void Function(bool starred) onStarChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: buildCard(context),
        ),
      );
    }
    return buildCard(context);
  }

  Widget buildCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (icon != null) ...[
                  IconTheme(data: IconTheme.of(context).copyWith(size: 20), child: icon!),
                  const SizedBox(width: 8),
                ],
                Text(title),
                Expanded(child: Container()),
                showStar
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          iconSize: 16,
                          icon: Icon(
                            starred ? Icons.star_rounded : Icons.star_border_rounded,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                          ),
                          onPressed: () => onStarChanged(!starred),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 6),
            Expanded(
              // child: Container(),
              // child: ConstrainedBox(
              //   constraints: BoxConstraints(minHeight: 20, maxHeight: 20),
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         top: 0,
              //         bottom: 0,
              //         left: 0,
              //         right: 0,
              //         child: MarkdownBody(
              //           data: description,
              //           // fitContent: true,
              //           // shrinkWrap: false,
              //           styleSheet: markdownStyleSheet,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              child: Text(
                description.isNotEmpty ? description : S.current.noDescription,
                overflow: TextOverflow.ellipsis,
                maxLines: dice.isNotEmpty
                    ? 3
                    : chips.isNotEmpty
                        ? 4
                        : 5,
                textScaleFactor: 0.9,
                style: const TextStyle(fontWeight: FontWeight.w200),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                ...chips,
                Expanded(child: Container()),
                if (dice.isNotEmpty)
                  BackgroundIconButton(
                    elevation: 1.5,
                    icon: const SvgIcon(DwIcons.dice_d6, size: 20),
                    iconColor: Theme.of(context).colorScheme.onPrimary,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                    onPressed: () => null,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect> {
  final Size size;

  RectClipper([
    double width = double.infinity,
    double height = double.infinity,
  ]) : size = Size(width, height);

  RectClipper.fromSize(this.size);

  @override
  Rect getClip(Size size) => Rect.fromLTWH(0, 0, size.width, size.height);

  @override
  bool shouldReclip(covariant RectClipper oldClipper) =>
      oldClipper.size.width != size.width || oldClipper.size.height != size.height;
}
