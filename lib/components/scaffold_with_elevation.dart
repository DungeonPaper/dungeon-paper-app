import 'package:flutter/material.dart';

class ScaffoldWithElevation extends StatefulWidget {
  final bool automaticallyImplyLeading;
  final Widget child;
  final Widget title;
  final List<Widget> actions;
  final Color backgroundColor;
  final bool _isThemePrimaryColor;
  final Widget appBarLeading;

  const ScaffoldWithElevation({
    Key key,
    @required this.child,
    @required this.title,
    this.actions,
    this.automaticallyImplyLeading = false,
    this.backgroundColor,
    this.appBarLeading,
  })  : _isThemePrimaryColor = false,
        super(key: key);

  const ScaffoldWithElevation.primaryBackground({
    Key key,
    this.automaticallyImplyLeading = false,
    @required this.child,
    @required this.title,
    this.actions,
    this.appBarLeading,
  })  : backgroundColor = null,
        _isThemePrimaryColor = true,
        super(key: key);

  @override
  _ScaffoldWithElevationState createState() => _ScaffoldWithElevationState();
}

class _ScaffoldWithElevationState extends State<ScaffoldWithElevation> {
  ScrollController scrollController = ScrollController();
  double appBarElevation = 0.0;

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  void scrollListener() {
    double newElevation = scrollController.offset > 16.0 ? 1.0 : 0.0;
    if (newElevation != appBarElevation) {
      setState(() {
        appBarElevation = newElevation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        controller: scrollController,
        child: widget.child,
      ),
    );
  }
}
