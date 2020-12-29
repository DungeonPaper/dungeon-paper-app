import 'package:dungeon_paper/src/atoms/card_list_item.dart';
import 'package:dungeon_paper/src/atoms/dice_icon.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:dungeon_world_data/alignment.dart' as dw_alignment;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassDescription extends StatelessWidget {
  final PlayerClass classDef;

  const ClassDescription({
    Key key,
    @required this.classDef,
  }) : super(key: key);

  static const spacer = SizedBox(height: 10.0);

  @override
  Widget build(BuildContext context) {
    var theme = Get.theme;
    var textTheme = theme.textTheme;
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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      classDef.description,
                      style: theme.textTheme.bodyText1
                          .copyWith(color: theme.accentColor),
                    ),
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
                            icon: DiceIcon(
                              dice: classDef.damage,
                              size: 40,
                            ),
                            label: Text('Damage Die'),
                            value: Text(classDef.damage.toString()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
    var theme = Get.theme;
    var textTheme = theme.textTheme;
    return Container(
      child: Column(
        children: <Widget>[
          IconTheme(
            child: icon,
            data: IconThemeData(color: theme.accentColor),
          ),
          DefaultTextStyle(
            child: value,
            style: textTheme.headline5.copyWith(
              fontSize: 30,
              color: theme.accentColor,
            ),
          ),
          DefaultTextStyle(
            child: label,
            style: textTheme.caption.copyWith(
              color: theme.accentColor,
            ),
          ),
        ],
      ),
    );
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
    var theme = Get.theme;
    var textTheme = theme.textTheme;

    if (!alignments.any((align) => align?.description?.isNotEmpty == true)) {
      return Container();
    }

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
              Text(
                'Available alignments:',
                style: textTheme.subtitle2.copyWith(
                  color: theme.accentColor,
                ),
              ),
              for (var alignment in alignments)
                TitleSubtitleRow(
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
