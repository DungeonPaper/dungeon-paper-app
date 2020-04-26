import 'package:dungeon_paper/components/card_list_item.dart';
import 'package:dungeon_paper/flutter_utils/flutter_utils.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:dungeon_world_data/alignment.dart' as dw_alignment;
import 'package:flutter/material.dart';

class ClassDescription extends StatelessWidget {
  final PlayerClass classDef;

  const ClassDescription({
    Key key,
    @required this.classDef,
  }) : super(key: key);

  static const spacer = SizedBox(height: 10.0);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Container(
      child: DefaultTextStyle(
        style: textTheme.bodyText2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'A little bit about ${classDef.name}s...',
              style: textTheme.headline6,
            ),
            spacer,
            Text(classDef.description),
            spacer,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  StatIcon(
                    icon: Icon(Icons.healing, size: 40.0),
                    label: Text('Base HP'),
                    value: Text(classDef.baseHP.toString()),
                  ),
                  StatIcon(
                    icon: PlatformSvg.asset(
                      'dice.svg',
                      // color: color,
                      width: 40.0,
                      height: 40.0,
                    ),
                    label: Text('Damage Die'),
                    value: Text(classDef.damage.toString()),
                  ),
                ],
              ),
            ),
            spacer,
            AlignmentList(alignments: classDef.alignments.values),
            // spacer,
          ],
        ),
      ),
    );
  }
}

class StatIcon extends StatelessWidget {
  const StatIcon({
    Key key,
    this.icon,
    @required this.value,
    this.label,
  }) : super(key: key);

  final Widget value;
  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Container(
        child: Column(
      children: <Widget>[
        icon,
        DefaultTextStyle(
          child: value,
          style: textTheme.headline5.copyWith(fontSize: 30),
        ),
        DefaultTextStyle(
          child: label,
          style: textTheme.caption,
        ),
      ],
    ));
  }
}

class AlignmentList extends StatelessWidget {
  const AlignmentList({
    Key key,
    @required this.alignments,
  }) : super(key: key);

  final Iterable<dw_alignment.Alignment> alignments;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: theme.primaryColorLight,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Available alignments:',
                  style:
                      textTheme.subtitle2.copyWith(color: theme.primaryColor)),
              for (var alignment in alignments)
                TitleSubtitleRow(
                  // contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                  title: Text(alignment.name),
                  subtitle: Text(alignment.description),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
