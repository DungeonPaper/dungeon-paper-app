import 'package:dungeon_paper/components/categorized_list.dart';
import 'package:dungeon_paper/components/title_subtitle_row.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class ChangeLooksDialog extends StatefulWidget {
  final PlayerClass playerClass;
  final List<String> looks;

  const ChangeLooksDialog({
    Key key,
    @required this.playerClass,
    @required this.looks,
  }) : super(key: key);

  @override
  _ChangeLooksDialogState createState() => _ChangeLooksDialogState();
}

class _ChangeLooksDialogState extends State<ChangeLooksDialog> {
  ScrollController scrollController = ScrollController();
  List<String> selected;
  double appBarElevation = 0.0;

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    selected = widget.looks.isEmpty
        ? List.generate(widget.playerClass.looks.length, (i) => null)
        : List.generate(widget.playerClass.looks.length,
            (i) => widget.looks.length >= i ? widget.looks[i] : null);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, List<String>> looksMap = widget.playerClass.looks.asMap();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          AppBar(
            title: Text('Change Looks'),
            elevation: appBarElevation,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save'),
                  color: Theme.of(context).canvasColor,
                  onPressed: () => changeLooks(selected),
                ),
              )
            ],
          ),
          Expanded(
            child: CategorizedList<int>.builder(
              itemCount: (key, i) => looksMap[key].length,
              categories: looksMap.keys,
              itemBuilder: (context, key, i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TitleSubtitleCard(
                      color: Theme.of(context).canvasColor.withOpacity(
                          selected[key] != null &&
                                  selected[key] != looksMap[key][i]
                              ? 0.7
                              : 1.0),
                      title: Text(looksMap[key][i]),
                      trailing: selected[key] == looksMap[key][i]
                          ? Icon(Icons.check)
                          : null,
                      onTap: () => setState(() {
                            selected[key] = looksMap[key][i];
                          }),
                    ),
                  ),
              titleBuilder: (context, key, i) => Text('Choose one:'),
            ),
          ),
        ],
      ),
    );
  }

  void changeLooks(List<String> def) async {
    DbCharacter char = dwStore.state.characters.current;
    char.looks = def;
    updateCharacter(char, [CharacterKeys.looks]);
    Navigator.pop(context, true);
  }

  void scrollListener() {
    double newElevation = scrollController.offset > 16.0 ? 1.0 : 0.0;
    if (newElevation != appBarElevation) {
      setState(() {
        appBarElevation = newElevation;
      });
    }
  }
}

class LooksDescription extends StatelessWidget {
  final void Function() onTap;
  final PlayerClass playerClass;
  final List<String> looks;

  const LooksDescription({
    Key key,
    this.onTap,
    @required this.playerClass,
    @required this.looks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleSubtitleCard(
      color: Theme.of(context)
          .canvasColor
          .withOpacity(playerClass.looks.isNotEmpty ? 1.0 : 0.85),
      title: Text('Looks'),
      leading: Icon(Icons.person_pin, size: 40),
      subtitle:
          Text(looks.isNotEmpty ? looks.join('; ') : 'No features selected'),
      trailing: Icon(Icons.chevron_right),
      onTap: playerClass.looks.isNotEmpty ? onTap : null,
    );
  }
}
