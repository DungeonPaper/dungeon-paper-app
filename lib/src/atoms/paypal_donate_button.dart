import 'dart:io';
import 'package:dungeon_paper/src/builders/secrets_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Platform.isIOS) return Container();
    return SecretsBuilder(
      builder: (secrets) {
        return RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          color: Color.fromRGBO(210, 163, 55, 1),
          textColor: Color.fromRGBO(37, 76, 111, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Text(
            'Donate via PayPal',
            textScaleFactor: 1.3,
          ),
          onPressed: () => launch(secrets.PAYPAL_DONATE_URL),
        );
      },
    );
  }
}
