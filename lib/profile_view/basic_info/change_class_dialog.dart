import 'package:dungeon_paper/profile_view/basic_info/edit_character_dialog.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:flutter/material.dart';

class ChangeClassDialog extends StatefulWidget {
  @override
  _ChangeClassDialogState createState() => _ChangeClassDialogState();
}

class _ChangeClassDialogState extends State<ChangeClassDialog> {
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
      ),
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Choose Class'),
            elevation: appBarElevation,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: dungeonWorld.classes.values
                      .map((availClass) => Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                            child: ClassSmallDescription(
                              playerClass: availClass,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
