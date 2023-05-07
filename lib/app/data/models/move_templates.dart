// ! TODO intl
class MoveTemplate {
  final String shortLabel;
  final String longLabel;
  final String text;
  final String help;

  const MoveTemplate({
    required this.shortLabel,
    required this.longLabel,
    required this.text,
    required this.help,
  });
}

class MoveTemplateList {
  static const templates = <MoveTemplate>[
    MoveTemplate(
      shortLabel: 'Simple',
      longLabel: 'Simple move',
      help: 'Basic template for simple move.',
      text: _singleBoth,
    ),
    MoveTemplate(
      shortLabel: 'Multi. choice',
      longLabel: 'Multiple choice success & trouble',
      help: 'Template with multiple options for success,\nand multiple options for trouble.',
      text: _multiBoth,
    ),
    MoveTemplate(
      shortLabel: 'Multi. success',
      longLabel: 'Multiple choice success',
      help: 'Template with multiple options for success,\nbut only one outcome for trouble.',
      text: _multiSuccess,
    ),
    MoveTemplate(
      shortLabel: 'Multi. trouble',
      longLabel: 'Multiple choice trouble',
      help: 'Template with multiple options for trouble,\nbut only one outcome for success.',
      text: _multiFail,
    ),
  ];

  static const _blank = '_____'; // or '…'?
  static const _bullet = '-';

  static const _singleBoth = 'When you $_blank, roll+STAT. On a 10+, you succeed $_blank. '
      'On a 7-9, you fail $_blank.';

  static const _multiSuccess = 'When you $_blank, roll+STAT. On a 10+, you succeed and choose:\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      'On a 7-9, you fail $_blank.';

  static const _multiFail = 'When you $_blank, roll+STAT. On a 10+, you succeed $_blank. On a 7-9, choose one:\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n';

  static const _multiBoth = 'When you $_blank, roll+STAT. On a 10+, you succeed and choose:\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      'On a 7-9, choose one:\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n'
      '  $_bullet $_blank\n';
}
