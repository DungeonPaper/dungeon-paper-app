import 'package:dungeon_paper/src/pages/scaffold/main_app_bar.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_paper/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScaffold extends StatefulWidget {
  final bool automaticallyImplyLeading;
  final Widget body;
  final Widget title;
  final List<Widget> actions;
  final Color backgroundColor;
  final Widget appBarLeading;
  final bool wrapWithScrollable;
  final bool useElevation;
  final double elevation;
  final Widget bottomNavigationBar;
  final Widget bottomSheet;
  final ScrollController scrollController;
  final Widget floatingActionButton;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget drawer;
  final bool useAppBar;

  const MainScaffold({
    Key key,
    @required this.body,
    @required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.appBarLeading,
    this.wrapWithScrollable = true,
    this.useElevation = true,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.scrollController,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.elevation,
    this.drawer,
    this.useAppBar = true,
  }) : super(key: key);

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  ScrollController scrollController;
  double appBarElevation;

  @override
  void initState() {
    super.initState();
    appBarElevation = widget.elevation ?? 0.0;
    scrollController = (widget.scrollController ?? ScrollController())
      ..addListener(scrollListener);
    if (!widget.useElevation && widget.elevation == null) appBarElevation = 1.0;
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MainScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      oldWidget.scrollController?.removeListener(scrollListener);
      scrollController = (widget.scrollController ?? ScrollController())
        ..addListener(scrollListener);
    }
  }

  void scrollListener() {
    if (!widget.useElevation) return;
    final newElevation =
        lerp(clamp(scrollController.offset, 0, 30), 0, 30, 0, 5);
    if (newElevation != appBarElevation) {
      setState(() {
        appBarElevation = newElevation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final wrappedChild = !widget.wrapWithScrollable
        ? widget.body
        : SingleChildScrollView(
            controller: scrollController,
            child: widget.body,
          );

    return GetBuilder<Themes>(
      builder: (themes) {
        return Scaffold(
          backgroundColor: widget.backgroundColor ??
              themes.current?.scaffoldBackgroundColor ??
              Get.theme.scaffoldBackgroundColor,
          appBar: widget.useAppBar != false
              ? MainAppBar(
                  title: widget.title,
                  elevation: appBarElevation,
                  automaticallyImplyLeading: widget.automaticallyImplyLeading,
                  actions: widget.actions,
                  leading: widget.appBarLeading,
                )
              : null,
          body: wrappedChild,
          bottomNavigationBar: widget.bottomNavigationBar,
          bottomSheet: widget.bottomSheet,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
          drawer: widget.drawer,
        );
      },
    );
  }
}
