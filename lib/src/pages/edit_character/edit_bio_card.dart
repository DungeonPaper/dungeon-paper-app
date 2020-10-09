import 'package:flutter/material.dart';

class EditBioCard extends StatelessWidget {
  final TextEditingController controller;

  const EditBioCard({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                maxLines: null,
                minLines: 3,
                controller: controller,
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Biography',
                  labelStyle: TextStyle(
                    fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                  ),
                  hintText: 'Tell us about your character.\n'
                      'Where it comes from, their motivation,\n'
                      'or anything you want.\n'
                      'Get creative!',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
