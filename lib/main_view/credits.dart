import 'package:flutter/material.dart';

const List<String> iconsCredits = [
  'ibrandify',
  'Freepik',
  'fontawesome',
];

class CreditsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle title = TextStyle(
      fontSize: 20.0,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Icons', style: title),
            SizedBox(height: 10.0),
            for (String credit in iconsCredits) ...[
              Text(credit),
              SizedBox(
                height: 2.0,
              )
            ],
          ],
        ),
      ),
    );
  }
}
