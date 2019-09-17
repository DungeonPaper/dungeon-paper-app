import 'dart:io';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import './feedback_button.dart';
import './paypal_donate_button.dart';
import '../../components/categorized_list.dart';
import '../../components/hyperlink.dart';
import '../../components/version_number.dart';
import 'package:flutter/material.dart';

const List<String> iconsCredits = [
  'ibrandify',
  'Freepik',
  'fontawesome',
];

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  final num year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Dungeon Paper'),
        actions: <Widget>[
          FeedbackButton.iconButton(),
        ],
      ),
      body: CategorizedList.childrenBuilder(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width),
                Text('Dungeon Paper',
                    style: Theme.of(context).textTheme.headline),
                VersionNumber.text(prefix: 'Version'),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Hyperlink(
                        text: 'Facebook',
                        url: 'https://facebook.com/dungeonpaper',
                      ),
                      Hyperlink(
                        text: 'Twitter',
                        url: 'https://twitte.com/dungeonpaper',
                      ),
                      Hyperlink(
                        text: 'GitHub',
                        url: 'https://github.com/chenasraf/dungeon-paper-app',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: SizedBox.fromSize(
                    size: Size.square(
                        min(MediaQuery.of(context).size.width - 32, 200)),
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(top: 0),
            child: Column(
              children: <Widget>[
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Develeoped by '),
                      TextSpan(
                        text: 'Chen Asraf',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launch('https://casraf.blog'),
                        style: TextStyle(
                          color: Color.fromRGBO(25, 118, 210, 1),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                Text('© 2018-$year'),
                SizedBox(height: 15),
                Text('Credits', style: Theme.of(context).textTheme.title),
                SizedBox(height: 10.0),
                Text('Icons', style: Theme.of(context).textTheme.subtitle),
                for (String credit in iconsCredits)
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Text(credit)),
                if (!Platform.isIOS)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      "\"I'm a humble dev,\nmaking this at night alone;\ncould you spare some coin?\"",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).textTheme.caption.color),
                      textScaleFactor: 0.7,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0).copyWith(top: 0),
                  child: DonateButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
