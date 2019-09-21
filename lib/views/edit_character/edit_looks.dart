import '../../components/categorized_list.dart';
import '../../components/title_subtitle_row.dart';
import '../../db/character.dart';
import '../../db/character_utils.dart';
import '../../components/dialogs.dart';
import 'character_wizard_utils.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class ChangeLooksDialog extends StatefulWidget {
  final DbCharacter character;
  final DialogMode mode;
  final CharSaveFunction onSave;
  final ScaffoldBuilderFunction builder;

  const ChangeLooksDialog({
    Key key,
    @required this.character,
    @required this.onSave,
    this.mode = DialogMode.Edit,
    this.builder,
  }) : super(key: key);

  ChangeLooksDialog.withScaffold({
    Key key,
    @required this.character,
    @required this.onSave,
    this.mode = DialogMode.Edit,
    Function() onDidPop,
    Function() onWillPop,
  })  : builder = characterWizardScaffold(
          mode: mode,
          titleText: 'Edit Looks',
          onDidPop: onDidPop,
          onWillPop: onWillPop,
          buttonType: WizardScaffoldButtonType.back,
        ),
        super(key: key);

  @override
  _ChangeLooksDialogState createState() => _ChangeLooksDialogState();
}

class _ChangeLooksDialogState extends State<ChangeLooksDialog> {
  List<String> selected;

  @override
  void initState() {
    selected = widget.character.looks.isEmpty
        ? List.generate(widget.character.mainClass.looks.length, (i) => null)
        : List.generate(
            widget.character.mainClass.looks.length,
            (i) => widget.character.looks.length >= i
                ? widget.character.looks[i]
                : null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var looksMap = widget.character.mainClass.looks;
    Widget child = CategorizedList<int>.builder(
      itemCount: (key, i) => looksMap[key].length,
      categories: looksMap.asMap().keys,
      itemBuilder: (context, looksCat, lookIdxInCat) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TitleSubtitleCard(
          color: Theme.of(context).canvasColor.withOpacity(
              selected.length > looksCat &&
                      selected[looksCat] != null &&
                      selected[looksCat] != looksMap[looksCat][lookIdxInCat]
                  ? 0.7
                  : 1.0),
          title: Text(looksMap[looksCat][lookIdxInCat]),
          trailing: selected.length > looksCat &&
                  selected[looksCat] == looksMap[looksCat][lookIdxInCat]
              ? Icon(Icons.check)
              : null,
          onTap: () => setState(() {
            if (selected[looksCat] == looksMap[looksCat][lookIdxInCat])
              selected[looksCat] = '';
            else
              selected[looksCat] = looksMap[looksCat][lookIdxInCat];
          }),
        ),
      ),
      titleBuilder: (context, key, i) => Text('Choose one:'),
    );
    if (widget.builder != null) {
      return widget.builder(
        context: context,
        child: child,
        save: () => changeLooks(selected),
        isValid: isValid,
        wrapWithScrollable: false,
      );
    }
    return child;
  }

  void changeLooks(List<String> def) async {
    widget.character.looks = def;
    widget.onSave(widget.character, [CharacterKeys.looks]);
  }

  bool isValid() {
    return true;
    // return selected.length == widget.character.mainClass.looks.length &&
    //     selected.every((s) => s != null && s.isNotEmpty);
  }
}

class LooksDescription extends StatelessWidget {
  final void Function() onTap;
  final PlayerClass playerClass;
  final List<String> looks;
  final Color color;
  final double elevation;
  final EdgeInsets margin;

  const LooksDescription({
    Key key,
    this.onTap,
    @required this.playerClass,
    @required this.looks,
    this.color,
    this.elevation,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleSubtitleCard(
      color: color ??
          Theme.of(context)
              .canvasColor
              .withOpacity(playerClass.looks.isNotEmpty ? 1.0 : 0.85),
      elevation: elevation,
      margin: margin,
      title: Text('Looks'),
      leading: Icon(Icons.person_pin, size: 40),
      subtitle:
          Text(looks.isNotEmpty ? looks.join('; ') : 'No features selected'),
      trailing: onTap != null ? Icon(Icons.chevron_right) : null,
      onTap: playerClass.looks.isNotEmpty ? onTap : null,
    );
  }
}
