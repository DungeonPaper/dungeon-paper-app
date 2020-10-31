import 'package:dungeon_paper/db/models/move_templates.dart';
import 'package:flutter/material.dart';

class MoveTemplateList extends StatelessWidget {
  final void Function(String message) onSelectTemplate;

  const MoveTemplateList({Key key, @required this.onSelectTemplate})
      : super(key: key);

  static const _defaultTemplates = <MoveTemplate>[
    MoveTemplate(
      label: 'Simple',
      help: 'Basic template for simple move.',
      text: _singleBoth,
    ),
    MoveTemplate(
      label: 'Multi. choice',
      help:
          'Template with multiple options for success,\nand multiple options for trouble.',
      text: _multiBoth,
    ),
    MoveTemplate(
      label: 'Multi. success',
      help:
          'Template with multiple options for success,\nbut only one outcome for trouble.',
      text: _multiSuccess,
    ),
    MoveTemplate(
      label: 'Multi. failure',
      help:
          'Template with multiple options for trouble,\nbut only one outcome for success.',
      text: _multiFail,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExpansionTile(
          title: Text('Move templates'),
          tilePadding: EdgeInsets.symmetric(vertical: 0),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tap template button to insert template text into "Description" box. '
              '(Inserts at current cursor position)\n'
              'Long-tap to preview template.',
            ),
            SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              // runSpacing: -6,
              children: [
                for (final template in _defaultTemplates) ...[
                  // Tooltip(
                  //   message: template.help,
                  // child:
                  ActionChip(
                    label: Text(template.label),
                    onPressed: () => onSelectTemplate?.call(template.text),
                    visualDensity: VisualDensity.compact,
                  ),
                  // ),
                  SizedBox(width: 8),
                ]
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ],
    );
  }

  static const _blank = '_____'; // or '…'?
  static const _bullet = '-';

  static const _singleBoth =
      'When you $_blank, roll+STAT. On a 10+, you succeed $_blank. '
      'On a 7-9, you fail $_blank.';

  static const _multiSuccess =
      'When you $_blank, roll+STAT. On a 10+, you succeed and choose:\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      'On a 7-9, you fail $_blank.';

  static const _multiFail =
      'When you $_blank, roll+STAT. On a 10+, you succeed $_blank. On a 7-9, choose one:\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n';

  static const _multiBoth =
      'When you $_blank, roll+STAT. On a 10+, you succeed and choose:\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      'On a 7-9, choose one:\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n';
}
