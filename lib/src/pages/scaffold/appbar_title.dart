import 'dart:io';
import 'package:flutter/foundation.dart';
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
  final defaultTitle = Text('Dungeon Paper');
  double page;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {
        page = widget.pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (page == null) {
      return Container();
    }
    var nextOpacity = 1.0 - (page.ceil() - page);
    var currentOpacity = page == page.ceil() ? 1.0 : (page.ceil() - page);
    var children = [
      Opacity(
        opacity: currentOpacity,
        child: currentPageTitle,
      ),
      Opacity(
        opacity: nextOpacity,
        child: nextPageTitle,
      ),
    ]
        .map((c) => SizedBox(
              child: c,
              width: 200,
            ))
        .toList();

    return DefaultTextStyle.merge(
      textAlign:
          kIsWeb || Platform.isAndroid ? TextAlign.left : TextAlign.center,
      child: Stack(children: children),
    );
  }

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
