import 'dart:io';
import 'dart:math';
import 'package:dungeon_paper/about_view/feedback_icon_button.dart';
import 'package:dungeon_paper/about_view/paypal_donate_button.dart';
import 'package:dungeon_paper/components/categorized_list.dart';
import 'package:dungeon_paper/components/hyperlink.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

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
  String version;

  @override
  void initState() {
    _getVersion();
    super.initState();
  }

  _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width),
                Text('Dungeon Paper',
                    style: Theme.of(context).textTheme.headline),
                Text('Version $version'),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Text('Develeoped by Chen Asraf'),
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
                Hyperlink(
                  'Dungeon Paper On Github',
                  'https://github.com/chenasraf/dungeon-paper-app',
                  padding:
                      const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
                ),
                Hyperlink(
                  'casraf.blog',
                  'https://casraf.blog',
                  padding:
                      const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
