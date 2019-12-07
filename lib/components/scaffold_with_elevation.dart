import 'package:flutter/material.dart';

class ScaffoldWithElevation extends StatefulWidget {
  final bool automaticallyImplyLeading;
  final Widget child;
  final Widget title;
  final List<Widget> actions;
  final Color backgroundColor;
  final bool _isThemePrimaryColor;
  final Widget appBarLeading;
  final bool wrapWithScrollable;
  final bool elevateAfterScrolling;
  final Widget bottomNavigationBar;
  final Widget bottomSheet;
  final ScrollController scrollController;

  const ScaffoldWithElevation({
    Key key,
    @required this.child,
    @required this.title,
    this.actions,
    this.automaticallyImplyLeading = false,
    this.backgroundColor,
    this.appBarLeading,
    this.wrapWithScrollable = true,
    this.elevateAfterScrolling = true,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.scrollController,
  })  : _isThemePrimaryColor = false,
        super(key: key);

  const ScaffoldWithElevation.primaryBackground({
    Key key,
    @required this.child,
    @required this.title,
    this.automaticallyImplyLeading = false,
    this.actions,
    this.appBarLeading,
    this.wrapWithScrollable = true,
    this.elevateAfterScrolling = true,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.scrollController,
  })  : backgroundColor = null,
        _isThemePrimaryColor = true,
        super(key: key);

  @override
  _ScaffoldWithElevationState createState() => _ScaffoldWithElevationState();
}

class _ScaffoldWithElevationState extends State<ScaffoldWithElevation> {
  ScrollController scrollController;
  double appBarElevation = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController = (widget.scrollController ?? ScrollController())
      ..addListener(scrollListener);
    if (!widget.elevateAfterScrolling) appBarElevation = 1.0;
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  void scrollListener() {
    double newElevation = scrollController.offset > 16.0 ? 1.0 : 0.0;
    if (!widget.elevateAfterScrolling) return;
    if (newElevation != appBarElevation) {
      setState(() {
        appBarElevation = newElevation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget wrappedChild = !widget.wrapWithScrollable
        ? widget.child
        : SingleChildScrollView(
            controller: scrollController,
            child: widget.child,
          );
    return Scaffold(
      backgroundColor: widget._isThemePrimaryColor
          ? Theme.of(context).primaryColor
          : widget.backgroundColor,
      appBar: AppBar(
        title: widget.title,
        elevation: appBarElevation,
        automaticallyImplyLeading: widget.automaticallyImplyLeading,
        actions: widget.actions,
        leading: widget.appBarLeading,
      ),
      body: wrappedChild,
      bottomNavigationBar: widget.bottomNavigationBar,
      bottomSheet: widget.bottomSheet,
    );
  }
}
