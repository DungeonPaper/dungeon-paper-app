import 'package:flutter/material.dart';

class ScaffoldWithElevation extends StatefulWidget {
  final bool automaticallyImplyLeading;
  final Widget body;
  final Widget title;
  final List<Widget> actions;
  final Color backgroundColor;
  final bool _isThemePrimaryColor;
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

  const ScaffoldWithElevation({
    Key key,
    @required this.body,
    @required this.title,
    this.actions,
    this.automaticallyImplyLeading = false,
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
  })  : _isThemePrimaryColor = false,
        super(key: key);

  const ScaffoldWithElevation.primaryBackground({
    Key key,
    @required this.body,
    @required this.title,
    this.automaticallyImplyLeading = false,
    this.actions,
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
  })  : backgroundColor = null,
        _isThemePrimaryColor = true,
        super(key: key);

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

  void scrollListener() {
    var newElevation = scrollController.offset > 16.0 ? 1.0 : 0.0;
    if (!widget.useElevation) return;
    if (newElevation != appBarElevation) {
      setState(() {
        appBarElevation = newElevation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var wrappedChild = !widget.wrapWithScrollable
        ? widget.body
        : SingleChildScrollView(
            controller: scrollController,
            child: widget.body,
          );
    return Scaffold(
      backgroundColor: widget._isThemePrimaryColor
          ? Theme.of(context).primaryColor
          : widget.backgroundColor,
      appBar: AppBar(
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Theme.of(context).colorScheme.secondary,
            ),
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.secondary),
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
    );
  }
}
