import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Pages { Home, Battle, Profile }

typedef Widget ColorBuilder(Color color);

class NavBar extends StatefulWidget {
  final PageController pageController;
  NavBar({Key key, @required this.pageController}) : super(key: key);

  @override
  NavBarState createState() => NavBarState(pageController: pageController);
}

class NavBarState extends State<NavBar> {
  final PageController pageController;
  num activePageIndex = 0;

  NavBarState({Key key, @required this.pageController});

  @override
  void initState() {
    pageController.addListener(this.pageListener);
    super.initState();
  }

  void pageListener() {
    setState(() {
      activePageIndex = pageController.page;
    });
  }

  Map<Pages, PageDetails> pageDetails = {
    Pages.Home: PageDetails(Text('Profile'),
        (color) => Icon(Icons.person, color: color), Pages.Home.index),
    Pages.Battle: PageDetails(
        Text('Battle'),
        (color) => SvgPicture.asset(
              'assets/swords.svg',
              color: color,
              width: 24,
              height: 24,
            ),
        Pages.Battle.index),
    Pages.Profile: PageDetails(
        Text('Notes'),
        (color) => Icon(Icons.speaker_notes, color: color),
        Pages.Profile.index),
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> pageItems = Pages.values.map((page) {
      PageDetails details = pageDetails[page];
      return PageNavItem(
          index: details.index,
          label: details.label,
          iconBuilder: details.iconBuilder,
          pageController: pageController);
    }).toList();

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: pageItems,
      ),
    );
  }

  @override
  void dispose() {
    pageController.removeListener(this.pageListener);
    super.dispose();
  }
}

class PageDetails {
  final Widget label;
  final ColorBuilder iconBuilder;
  final num index;

  PageDetails(this.label, this.iconBuilder, this.index);
}

class PageNavItem extends StatelessWidget {
  const PageNavItem({
    Key key,
    @required this.index,
    @required this.pageController,
    @required this.label,
    @required this.iconBuilder,
  }) : super(key: key);

  final num index;
  final PageController pageController;
  final Widget label;
  final ColorBuilder iconBuilder;

  @override
  Widget build(BuildContext context) {
    // var _color = pageController.page.round() == index
    //     ?
    //     : Theme.of(context).colorScheme.onSurface;
    double activeIdx = pageController.page != null ? pageController.page : 0.0;
    double t = clamp((activeIdx - index).abs(), 0, 1);
    Color _color = Color.lerp(Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.onSurface, t);

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: 60,
          child: InkWell(
            onTap: () {
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutQuart);
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                iconBuilder(_color),
                DefaultTextStyle(style: TextStyle(color: _color), child: label)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
