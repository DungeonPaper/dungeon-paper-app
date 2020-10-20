import 'package:dungeon_paper/src/pages/scaffold/main_app_bar.dart';
import 'package:flutter/material.dart';

class ScaffoldWithElevation extends StatefulWidget {
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

  const ScaffoldWithElevation({
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
  }) : super(key: key);

  @override
  _ScaffoldWithElevationState createState() => _ScaffoldWithElevationState();
}

class _ScaffoldWithElevationState extends State<ScaffoldWithElevation> {
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
  void didUpdateWidget(covariant ScaffoldWithElevation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      oldWidget.scrollController?.removeListener(scrollListener);
      scrollController = (widget.scrollController ?? ScrollController())
        ..addListener(scrollListener);
    }
  }

  void scrollListener() {
    final newElevation = scrollController.offset > 16.0 ? 1.0 : 0.0;
    if (!widget.useElevation) return;
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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? theme.scaffoldBackgroundColor,
      appBar: MainAppBar(
        title: widget.title,
        elevation: appBarElevation,
        automaticallyImplyLeading: widget.automaticallyImplyLeading,
        actions: widget.actions,
        leading: widget.appBarLeading,
      ),
      body: wrappedChild,
      bottomNavigationBar: widget.bottomNavigationBar,
      bottomSheet: widget.bottomSheet,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      drawer: widget.drawer,
    );
  }
}
