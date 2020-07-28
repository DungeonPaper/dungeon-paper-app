import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/user.dart';
import 'package:dungeon_paper/src/dialogs/roll_dice_dialog.dart';
import 'package:dungeon_paper/src/flutter_utils/platform_svg.dart';
import 'package:dungeon_paper/src/flutter_utils/widget_utils.dart';
import 'package:dungeon_paper/src/pages/battle_view/battle_view.dart';
import 'package:dungeon_paper/src/pages/home_view/home_view.dart';
import 'package:dungeon_paper/src/pages/inventory_view/inventory_view.dart';
import 'package:dungeon_paper/src/pages/notes_view/notes_view.dart';
import 'package:dungeon_paper/src/pages/reference_view/reference_view.dart';
import 'package:dungeon_paper/src/pages/welcome_view/welcome_view.dart';
import 'package:dungeon_paper/src/pages/whats_new_view/whats_new_view.dart';
import 'package:dungeon_paper/src/redux/connectors.dart';
import 'package:dungeon_paper/src/redux/loading/loading_store.dart';
import 'package:dungeon_paper/src/redux/shared_preferences/prefs_store.dart';
import 'package:dungeon_paper/src/redux/stores.dart';
import 'package:dungeon_paper/src/utils/analytics.dart';
import 'package:dungeon_paper/src/utils/logger.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:package_info/package_info.dart';
import 'package:pedantic/pedantic.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appbar_title.dart';
import 'fab.dart';
import 'nav_bar.dart';
import 'sidebar.dart';
import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  MainContainer({
    Key key,
    @required this.title,
    this.pageController,
  }) : super(key: key);

  final String title;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector<DWStore>(
      builder: (ctx, state) {
        var character = state.characters.current;
        var user = state.user.current;
        return MainView(
          character: character,
          user: user,
          loading: state.loading[LoadingKeys.Character] ||
              state.loading[LoadingKeys.User],
          pageController: pageController,
        );
      },
    );
  }
}

class MainView extends StatefulWidget {
  final Character character;
  final User user;
  final bool loading;
  final PageController pageController;

  MainView({
    Key key,
    @required this.character,
    @required this.user,
    @required this.loading,
    @required this.pageController,
  }) : super(key: key);

  static Widget bottomSpacer = BOTTOM_SPACER;

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final Map<Pages, Widget Function(Character character)> pageMap = {
    Pages.Home: (character) => ProfileView(character: character),
    Pages.Battle: (character) => BattleView(character: character),
    Pages.Inventory: (character) => InventoryView(character: character),
    Pages.Notes: (character) => NotesView(character: character),
    Pages.Reference: (character) => ReferenceView(),
  };
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  double elevation = 0.0;
  String lastPageName = 'Home';

  @override
  void initState() {
    widget.pageController.addListener(_pageListener);
    _showWhatsNew();
    super.initState();
  }

  String get pageName => enumName(
        Pages.values.elementAt(
          widget.pageController?.page?.toInt?.call() ?? 0,
        ),
      );

  @override
  Widget build(BuildContext context) {
    Widget homeWidget = PageView(
      controller: widget.pageController,
      children: widget.character != null
          ? pages
          : [
              WelcomeView(
                loading: widget.loading,
                pageController: widget.pageController,
              )
            ],
    );
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(pageController: widget.pageController),
        elevation: elevation,
        actions: widget.character != null
            ? [
                IconButton(
                  tooltip: 'Roll Dice',
                  icon:
                      PlatformSvg.asset('dice/d20.svg', width: 24, height: 24),
                  onPressed: () {
                    showDiceRollDialog(
                      context: context,
                      character: widget.character,
                      analyticsSource: pageName,
                    );
                  },
                )
              ]
            : null,
      ),
      drawer: drawer,
      floatingActionButton: fab,
      floatingActionButtonLocation: fabLocation,
      bottomNavigationBar: navBar,
      body: homeWidget,
    );
  }

  Widget get fab => widget.character != null
      ? FAB(pageController: widget.pageController, character: widget.character)
      : null;

  FloatingActionButtonLocation get fabLocation =>
      widget.character != null ? FloatingActionButtonLocation.endFloat : null;

  Widget get drawer =>
      widget.user != null && widget.character != null ? Sidebar() : null;

  List<Widget> get pages => Pages.values.map((page) {
        var builder = pageMap[page];
        if (builder != null) {
          return builder(widget.character);
        }
        return Center(child: Text('To Do!'));
      }).toList();

  Widget get navBar => widget.character != null
      ? NavBar(pageController: widget.pageController)
      : null;

  void _showWhatsNew() async {
    var packageInfo = await PackageInfo.fromPlatform();
    var sharedPrefs = await SharedPreferences.getInstance();
    var lastVersionKey = enumName(SharedPrefKeys.LastOpenedVersion);
    Version lastViewedAt;
    if (sharedPrefs.containsKey(lastVersionKey)) {
      lastViewedAt = Version.parse(sharedPrefs.getString(lastVersionKey));
    }
    if (lastViewedAt == null ||
        lastViewedAt < Version.parse(packageInfo.version)) {
      unawaited(showDialog(
        context: context,
        builder: (context) => WhatsNew.dialog(),
      ));
    }
    unawaited(sharedPrefs.setString(lastVersionKey, packageInfo.version));
  }

  void _pageListener() {
    if (widget.pageController.hasClients) {
      if (clamp01(widget.pageController.page) != elevation) {
        setState(() {
          elevation = clamp01(widget.pageController.page);
        });
      }
      if (widget.pageController.page.round() == widget.pageController.page) {
        if (pageName != lastPageName) {
          setState(() {
            lastPageName = pageName;
          });
          logger.d('Page View: $pageName (from: $lastPageName)');
          analytics.setCurrentScreen(
            screenName: pageName,
          );
        } else {
          analytics.logEvent(name: Events.ReturnToScreen, parameters: {
            'screen_name': lastPageName,
          });
        }
      }
    }
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_pageListener);
    super.dispose();
  }
}
