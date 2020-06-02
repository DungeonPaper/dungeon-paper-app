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
import 'package:dungeon_paper/src/utils/utils.dart';
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
    return DWStoreConnector<DWStore>(builder: (ctx, state) {
      var character = state.characters.current;
      var user = state.user.current;
      return MainView(
        character: character,
        user: user,
        loading: state.loading[LoadingKeys.Character] ||
            state.loading[LoadingKeys.User],
        pageController: pageController,
      );
    });
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

  double elevation = 0.0;

  @override
  void initState() {
    widget.pageController.addListener(() {
      if (widget.pageController.hasClients &&
          clamp01(widget.pageController.page) != elevation) {
        setState(() {
          elevation = clamp01(widget.pageController.page);
        });
      }
    });
    _showWhatsNew();
    super.initState();
  }

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
        // actions: [
        //   IconButton(
        //     tooltip: 'Roll Dice',
        //     icon: PlatformSvg.asset('dice.svg', width: 24, height: 24),
        //     onPressed: () => showDialog(
        //       context: context,
        //       builder: (context) => RollDiceDialog(),
        //     ),
        //   )
        // ],
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

  Widget get drawer => widget.user != null ? Sidebar() : null;

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
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String lastVersionKey = enumName(SharedPrefKeys.LastOpenedVersion);
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
}
