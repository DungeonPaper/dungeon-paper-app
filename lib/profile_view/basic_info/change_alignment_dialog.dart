import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/character_types.dart' as Chr;
import 'package:dungeon_paper/profile_view/edit_character/alignment_description_card.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_world_data/player_class.dart';
import 'package:flutter/material.dart';

class ChangeAlignmentDialog extends StatefulWidget {
  final PlayerClass playerClass;

  const ChangeAlignmentDialog({
    Key key,
    @required this.playerClass,
  }) : super(key: key);

  @override
  _ChangeAlignmentDialogState createState() => _ChangeAlignmentDialogState();
}

class _ChangeAlignmentDialogState extends State<ChangeAlignmentDialog> {
  ScrollController scrollController = ScrollController();
  double appBarElevation = 0.0;

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Choose Alignment'),
        elevation: appBarElevation,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: Chr.Alignment.values
                .map(
                  (alignment) => Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: AlignmentDescription(
                          playerClass: widget.playerClass,
                          alignment: alignment,
                          onTap: changeAlignment(alignment),
                        ),
                      ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Function() changeAlignment(Chr.Alignment def) {
    return () async {
      DbCharacter char = dwStore.state.characters.current;
      char.alignment = def;
      updateCharacter(char, [CharacterKeys.alignment]);
      Navigator.pop(context, true);
    };
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
