import '../../widget_utils.dart';
import '../battle_view/battle_view.dart';
import '../../db/character.dart';
import '../../db/user.dart';
import '../equipment_view/inventory_view.dart';
import '../notes_view/notes_view.dart';
import '../basic_info/profile_view.dart';
import '../../redux/stores/connectors.dart';
import '../../redux/stores/loading_store.dart';
import '../reference_view/reference_view.dart';
import '../../utils.dart';
import 'appbar_title.dart';
import 'fab.dart';
import 'nav_bar.dart';
import 'sidebar.dart';
import 'welcome.dart';
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
    return DWStoreConnector(builder: (ctx, state) {
      DbCharacter character = state.characters.current;
      DbUser user = state.user.current;
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
  final DbCharacter character;
  final DbUser user;
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
  final Map<Pages, Widget Function(DbCharacter character)> pageMap = {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageView homeWidget = PageView.builder(
      controller: widget.pageController,
      itemBuilder: (context, idx) => widget.character == null
          ? Welcome(
              loading: widget.loading,
              pageController: widget.pageController,
            )
          : pages[idx],
      itemCount: widget.character == null ? 1 : pages.length,
    );
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(pageController: widget.pageController),
        elevation: elevation,
      ),
      drawer: drawer,
      floatingActionButton: fab,
      floatingActionButtonLocation: fabLocation,
      bottomNavigationBar: navBar,
      body: homeWidget,
    );
  }

  Widget get fab => widget.character != null
      ? FAB(pageController: widget.pageController)
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
}
