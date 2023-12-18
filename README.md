# Dungeon Paper

[![facebook](https://img.shields.io/static/v1?label=Like&style=social&logo=facebook&message=%20)](https://bit.ly/DungeonPaper-Facebook)
[![twitter](https://img.shields.io/twitter/follow/espadrine?label=Follow&style=social)](https://bit.ly/DungeonPaper-Twitter)
[![discord](https://img.shields.io/discord/719848105586982915?label=Chat&logo=discord&style=social)](https://bit.ly/DungeonPaper-Discord)

Dungeon World players, this is the app for you!

Keep all your characters' bio, stats, moves and possessions with this interactive character sheet.
Join for smoother, zero-hustle Dungeon World campaigns!

Dungeon Paper is an interactive character sheet for your Dungeon World characters. This is the
source of this app, but to fully use it you must set up your own firebase credentials and sign your
own app. Once that is properly set up, the app should create entities based on logins to the app, so
nothing else should be created for the database beforehand. No one in this repository will provide
any secret keys to anyone, ever.

![dungeon paper](https://dungeonpaper.app/assets/images/logo-512.png)

[![android](https://img.shields.io/static/v1?label=Google%20Play&style=for-the-badge&logo=google-play&message=%E2%80%BA&labelColor=689f38&color=33691e&)](https://bit.ly/DungeonPaper-Android)
[![ios](https://img.shields.io/static/v1?label=App%20Store&style=for-the-badge&logo=apple&message=%E2%80%BA&labelColor=000000&color=000000&)](https://bit.ly/DungeonPaper-iOS)

## Features

- Unlimited number of character sheets
- Create your own classes and races to use for your characters
- Add basic details (character name, image, race and alignment)
- Set and view stats and modifiers, life, experience, armor and damage dice
- Add moves and spells from the playbook, or add your own homebrew
- Keep track of inventory items, coins and load
- Add notes, moves, spells, and other custom content with rich text, checkboxes and tables using
  Markdown
- Roll any dice or roll your actions directly

---

## Contributing

I am developing this package on my free time, so any support, whether code, issues, or just stars is
very helpful to sustaining its life. If you are feeling incredibly generous and would like to donate
just a small amount to help sustain this project, I would be very very thankful!

<a href='https://ko-fi.com/casraf' target='_blank'>
  <img height='36' style='border:0px;height:36px;'
    src='https://cdn.ko-fi.com/cdn/kofi1.png?v=3'
    alt='Buy Me a Coffee at ko-fi.com' />
</a>

I welcome any issues or pull requests on GitHub. If you find a bug, or would like a new feature,
don't hesitate to open an appropriate issue and I will do my best to reply promptly.

### Development Set Up

1. Download Flutter

   Use whatever Flutter channel you deem necessary, this should be compatible with master and beta,
   dev breaks a lot so no commitment. More information on [Flutter.dev](https://flutter.dev).

1. Fork this repository

1. Connect your Firebase credentials for the app

   - [Android Instructions](https://firebase.google.com/docs/android/setup)
   - [iOS Instructions](https://firebase.google.com/docs/ios/setup)

   TL;DR: Create Firebase app, setup authentication, and run

   ```shell
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

1. Add your firebase secrets, put this template in `lib/core/utils/secrets.dart` and update the
   values

   ```dart
   part of 'secrets_base.dart';

   class Secrets extends SecretsBase {
     @override
     final String sentryDsn = '<sentry dsn value>';
   }
   ```

   Sentry DSN can remain empty to skip error reporting.

1. To run build scripts, install [script_runner](https://pub.dev/packages/script_runner) and use
   `scr -h` to see all available commands

As mentioned above, Firebase secret keys must be your own, and so are the databases and services
related to them. This project uses Firebase auth and Cloud Firestore.

### Translations

This app is currently only available in English. However, it's possible to contribute translations
if you wish to help localize the app to your language. The app should be fully-localizable easily by
just updating the translation files.

- The current main translations file is at `lib/i18n/messages.i18n.yaml`
- To add a new localization file, copy this file to `lib/i18n/messages_<lang code>.i18n.yaml` (for
  example, for Hebrew you would use `messages_he.i18n.yaml`)
- For help using the translation syntax, see the [i18n docs](https://github.com/MohiuddinM/i18n)
- To translate the playbook data (classes, items, moves, spells, etc) we must localize a separate
  package containing all the Dungeon World base data. This package is
  [available here](https://github.com/DungeonPaper/dungeon_world_data), see the localization docs
  there for more help.
- The app and data may be translated separately and do not depend on each other.
- Use the build_runner package to generate Dart files from the yaml files.

  ```bash
  # run in watch mode, re-generates as you update the yaml
  dart run build_runner watch
  # generate files once
  dart run build_runner build
  ```

### Help by bug reporting or requesting features

- Feel free to use the GitHub issues to post one of the issue templates.
- We are also active on [Discord](https://bit.ly/DungeonPaper-Discord)
