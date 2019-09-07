import 'nav_bar.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return AppBarTitleText(pageController: pageController);
  }
}

class AppBarTitleText extends StatefulWidget {
  final PageController pageController;

  static Map<Pages, Widget> pageTitleMap = {
    Pages.Battle: Text('Battle'),
    Pages.Reference: Text('Reference'),
    Pages.Inventory: Text('Inventory'),
    Pages.Notes: Text('Notes'),
  };

  const AppBarTitleText({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  @override
  _AppBarTitleTextState createState() => _AppBarTitleTextState();
}

class _AppBarTitleTextState extends State<AppBarTitleText> {
  double page;

  @override
  initState() {
    widget.pageController.addListener(() {
      setState(() {
        page = widget.pageController.page;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (page == null) {
      return defaultTitle;
    }
    var nextOpacity = 1.0 - (page.ceil() - page);
    var currentOpacity = page == page.ceil() ? 1.0 : (page.ceil() - page);
    var children = [
      Opacity(
        opacity: nextOpacity,
        child: nextPageTitle,
      ),
      Opacity(
        opacity: currentOpacity,
        child: currentPageTitle,
      ),
    ];
    return Stack(
      children: children.reversed.toList(),
    );
  }

  Widget get defaultTitle => Text('Dungeon Paper');

  Pages get currentPage => widget.pageController.page != null
      ? Pages.values[widget.pageController.page.floor()]
      : null;
  Pages get nextPage => widget.pageController.page != null
      ? Pages.values[widget.pageController.page.ceil()]
      : null;

  num get currentPageIdx => widget.pageController.page?.floor();
  num get nextPageIdx => widget.pageController.page?.round();

  Widget get currentPageTitle => currentPage != null
      ? AppBarTitleText.pageTitleMap[currentPage] ?? defaultTitle
      : defaultTitle;
  Widget get nextPageTitle => nextPage != null
      ? AppBarTitleText.pageTitleMap[nextPage] ?? currentPageTitle
      : currentPageTitle;
}
