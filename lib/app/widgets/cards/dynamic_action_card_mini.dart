import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/round_roll_button.dart';
import 'package:dungeon_paper/core/utils/markdown_styles.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class DynamicActionCardMini extends StatelessWidget {
  const DynamicActionCardMini({
    super.key,
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
    this.abilityScores,
  }) : assert(dice.length == 0 || abilityScores != null);

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
  final AbilityScores? abilityScores;

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;
    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: Card(
          color: cardColor,
          margin: EdgeInsets.zero,
          child: InkWell(
            borderRadius: borderRadius,
            splashColor: Theme.of(context).splashColor,
            onTap: onTap,
            child: buildCardContent(context),
          ),
        ),
      );
    }
    return Card(
      color: cardColor,
      margin: EdgeInsets.zero,
      child: buildCardContent(context),
    );
  }

  Padding buildCardContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final titleFgColor = colorScheme.secondary;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (icon != null) ...[
                IconTheme(
                  data: IconTheme.of(context).copyWith(
                    size: 20,
                    color: titleFgColor,
                  ),
                  child: icon!,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: textTheme.bodyLarge!.copyWith(
                    color: titleFgColor,
                  ),
                ),
              ),
              showStar
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        width: 24,
                        height: 20,
                        child: IconButton(
                          // visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          iconSize: 16,
                          icon: IconTheme(
                            data: IconTheme.of(context).copyWith(
                              size: 16,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.3),
                            ),
                            child: starred
                                ? starredIcon ??
                                    const Icon(
                                      Icons.star_rounded,
                                      color: DwColors.gold,
                                    )
                                : unstarredIcon ??
                                    const Icon(Icons.star_border_rounded),
                          ),
                          onPressed: () => onStarChanged(!starred),
                        ),
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
                  data: description.isNotEmpty
                      ? description
                      : tr.generic.noDescription,
                  // fitContent: true,
                  // shrinkWrap: true,
                  // fitContent: true,
                  styleSheet:
                      MarkdownStyles.of(context).copyWith(textScaleFactor: 0.9),
                  physics: const NeverScrollableScrollPhysics(),
                  onTapLink: (text, href, title) => launchUrl(Uri.parse(href!)),
                ),
              );
            }),
            // child: Text(
            //   description.isNotEmpty ? description : tr.playbook.data.noDescription,
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
                RoundRollButton(
                  dice: dice,
                  size: 45,
                  abilityScores: abilityScores,
                ),
            ],
          )
        ],
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
      oldClipper.size.width != size.width ||
      oldClipper.size.height != size.height;
}
