import 'package:dungeon_paper/character_connector.dart';
import 'package:dungeon_paper/character_headliner.dart';
import 'package:dungeon_paper/user_connector.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserConnector(
      loader: CircularProgressIndicator(value: null),
      builder: (context, user) {
        if (user == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[Center(child: const Text('Please log in!'))],
          );
        }

        return CharacterConnector(
          loader: CircularProgressIndicator(value: null),
          builder: (context, character) {
            if (character == null) {
              return const Text('Do you have any characters?');
            }

            List<Widget> charImageWidget = character.photoURL != null
                ? [
                    Container(
                        height: MediaQuery.of(context).size.height / 4.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          alignment: FractionalOffset.topCenter,
                          image: NetworkImage(character.photoURL),
                        )))
                  ]
                : [];

            return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: charImageWidget +
                    <Widget>[CharacterHeadline(character: character)]);
          },
        );
      },
    );
  }
}
