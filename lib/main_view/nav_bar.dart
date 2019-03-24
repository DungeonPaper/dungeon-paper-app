import 'package:dungeon_paper/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Pages { Home, Battle, Reference, Equipment, Notes }

typedef Widget ColorBuilder(Color color);

class NavBar extends StatefulWidget {
  final PageController pageController;
  NavBar({Key key, @required this.pageController}) : super(key: key);

  @override
  NavBarState createState() => NavBarState(pageController: pageController);
}

class NavBarState extends State<NavBar> {
  final PageController pageController;
  double activePageIndex = 0;

  NavBarState({Key key, @required this.pageController});

  @override
  void initState() {
    pageController.addListener(pageListener);
    super.initState();
  }

  void pageListener() {
    if (pageController.hasClients && pageController.page != activePageIndex) {
      setState(() {
        activePageIndex = pageController.page;
      });
    }
  }

  Map<Pages, PageDetails> pageDetails = {
    Pages.Home: PageDetails(
        Text('Profile'), (color) => Icon(Icons.person, color: color)),
    Pages.Battle: PageDetails(
        Text('Battle'),
        (color) => SvgPicture.asset(
              'assets/swords.svg',
              color: color,
              width: 24,
              height: 24,
            )),
    Pages.Notes: PageDetails(
        Text('Notes'), (color) => Icon(Icons.speaker_notes, color: color)),
    Pages.Equipment: PageDetails(
        Text('Inventory'),
        (color) => SvgPicture.asset(
              // 'assets/armor.svg',
              'assets/bag.svg',
              color: color,
              width: 24,
              height: 24,
            )),
    Pages.Reference: PageDetails(
        Text('Reference'), (color) => Icon(CupertinoIcons.book_solid, color: color,)),
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> pageItems = Pages.values.map((page) {
      PageDetails details = pageDetails[page];
      double t = clamp((activePageIndex - page.index).abs(), 0, 1);
      Color color = Color.lerp(Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.onSurface, t);

      if (details == null) {
        return Center(child: Text('To Do!'));
      }

      return PageNavItem(
        foregroundColor: color,
        label: details.label,
        iconBuilder: details.iconBuilder,
        onChangePage: () => pageController.animateToPage(page.index,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutQuart),
      );
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
    pageController.removeListener(pageListener);
    super.dispose();
  }
}

class PageDetails {
  final Widget label;
  final ColorBuilder iconBuilder;

  PageDetails(this.label, this.iconBuilder);
}

class PageNavItem extends StatelessWidget {
  const PageNavItem(
      {Key key,
      @required this.label,
      @required this.iconBuilder,
      @required this.foregroundColor,
      @required this.onChangePage})
      : super(key: key);

  final Color foregroundColor;
  final Widget label;
  final ColorBuilder iconBuilder;
  final Function onChangePage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: 60,
          child: InkWell(
            onTap: onChangePage,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                iconBuilder(foregroundColor),
                DefaultTextStyle(
                    style: TextStyle(color: foregroundColor), child: label)
              ],
            ),
          ),
        ),
      ),
    );
  }
}