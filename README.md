# Dungeon Paper

[![facebook](https://img.shields.io/static/v1?label=Like&style=social&logo=facebook&message=%20)](https://bit.ly/DungeonPaper-Facebook)
[![twitter](https://img.shields.io/twitter/follow/espadrine?label=Follow&style=social)](https://bit.ly/DungeonPaper-Twitter)
[![discord](https://img.shields.io/discord/719848105586982915?label=Chat&logo=discord&style=social)](https://bit.ly/DungeonPaper-Discord)

Dungeon World players, this is the app for you!

Keep all your characters' bio, stats, moves and possessions with this interactive character sheet. Join for smoother, zero-hustle Dungeon World campaigns!

Dungeon Paper is an interactive character sheet for your Dungeon World characters.
This is the source of this app, but to fully use it you must set up your own firebase credentials and sign your own app.
Once that is properly set up, the app should create entities based on logins to the app, so nothing else should be created for the database beforehand.
No one in this repository will provide any secret keys to anyone, ever.

## Dungeon Paper is available on [Google Play](https://bit.ly/DungeonPaper-Android).

## Features

* Unlimited number of character sheets
* Create your own classes and races to use for your characters
* Add basic details (character name, image, race and alignment)
* Set and view stats and modifiers, life, experience, armor and damage dice
* Add moves and spells from the playbook, or add your own homebrew
* Keep track of inventory items, coins and load
* Add notes and organize them into categories, to keep track of everything going on in your group's campaign and your character
* Roll dice from anywhere in the app

## Development Set Up

1. Download Flutter

    Use whatever Flutter channel you deem necessary, this should be compatible with master and beta, dev breaks a lot so no commitment.  
    More information on [Flutter.dev](https://flutter.dev).

1.  Connect your Firebase credentials for the app

    - [Android Instructions](https://firebase.google.com/docs/android/setup)
    - [iOS Instructions](https://firebase.google.com/docs/ios/setup)

1. Build & Run the project

---

# CONTRIBUTING

## Help with code

1. Fork this repository
1. Run the project, and make your changes.
1. Do your best to make sure nothing breaks. There are minimal tests so try QAing the change yourself before proceeding
1. Create a PR once you have a stable contribution

As mentioned above, Firebase secret keys must be your own, and so are the databases and services related to them.
This project uses Firebase auth, Firestore, and Crashlytics.

## Help by bug reporting or requesting features
- Feel free to use the GitHub issues to post one of the issue templates.
- We are also active on [Discord](https://bit.ly/DungeonPaper-Discord)
