import 'dart:io';

import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateButton extends StatefulWidget {
  @override
  _DonateButtonState createState() => _DonateButtonState();
}

class _DonateButtonState extends State<DonateButton> {
  Map secrets = {};

  @override
  initState() {
    loadSecrets().then((s) {
      setState(() {
        secrets = s;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) return Container();
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      color: Color.fromRGBO(210, 163, 55, 1),
      textColor: Color.fromRGBO(37, 76, 111, 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Text('Donate via PayPal', textScaleFactor: 1.3,),
      onPressed: () =>
          secrets != null ? launch(secrets['PAYPAL_DONATE_URL']) : null,
    );
  }
}
