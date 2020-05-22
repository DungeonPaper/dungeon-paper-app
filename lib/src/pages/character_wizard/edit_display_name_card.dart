
import 'package:flutter/material.dart';

class EditDisplayNameCard extends StatelessWidget {
  final TextEditingController controller;

  const EditDisplayNameCard({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).canvasColor,
      elevation: 1.0,
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(top: 0.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Character name',
                  labelStyle: TextStyle(
                    fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                  ),
                  hintText: "Your character's name",
                ),
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline6.fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
