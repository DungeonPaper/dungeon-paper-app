import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

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
                Expanded(child: Text(title, overflow: TextOverflow.ellipsis, maxLines: 1)),
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
              child: LayoutBuilder(builder: (context, constraints) {
                return ClipRect(
                  // clipper: RectClipper(constraints.maxWidth, constraints.maxHeight),
                  child: Markdown(
                    padding: EdgeInsets.zero,
                    data: description.isNotEmpty ? description : S.current.noDescription,
                    // fitContent: true,
                    // shrinkWrap: true,
                    // fitContent: true,
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                        .copyWith(textScaleFactor: 0.9),
                    physics: const NeverScrollableScrollPhysics(),
                    onTapLink: (text, href, title) => launch(href!),
                  ),
                );
              }),
              // child: Text(
              //   description.isNotEmpty ? description : S.current.noDescription,
              //   overflow: TextOverflow.ellipsis,
              //   maxLines: dice.isNotEmpty
              //       ? 3
              //       : chips.isNotEmpty
              //           ? 4
              //           : 5,
              //   textScaleFactor: 0.9,
              //   style: const TextStyle(fontWeight: FontWeight.w200),
              // ),
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
                    onPressed: () => DiceUtils.openRollDialog(dice),
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
