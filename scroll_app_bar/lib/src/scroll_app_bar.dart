import 'package:flutter/material.dart';

import 'scroll_app_bar_controller.dart';

class ScrollAppBar extends StatefulWidget with PreferredSizeWidget {
  ScrollAppBar({
    Key key,
    @required this.scrollAppBarController,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shape,
    this.backgroundColor,
    this.backgroundGradient,
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
  })  : assert(scrollAppBarController != null),
        super(key: key);

  final ScrollAppBarController scrollAppBarController;
  final Widget leading;
  final bool automaticallyImplyLeading;
  final Widget title;
  final List<Widget> actions;
  final Widget flexibleSpace;
  final PreferredSizeWidget bottom;
  final double elevation;
  final Color backgroundColor;
  final Gradient backgroundGradient;
  final Brightness brightness;
  final IconThemeData iconTheme;
  final IconThemeData actionsIconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final double titleSpacing;
  final ShapeBorder shape;
  final double bottomOpacity;
  final double toolbarOpacity;

  @override
  _ScrollAppBarState createState() => _ScrollAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ScrollAppBarState extends State<ScrollAppBar> {
  Widget appBar;
  double elevation;
  Color backgroundColor;

  @override
  void initState() {
    super.initState();

    appBar = AppBar(
      leading: widget.leading,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      title: widget.title,
      actions: widget.actions,
      flexibleSpace: widget.flexibleSpace,
      bottom: widget.bottom,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      brightness: widget.brightness,
      iconTheme: widget.iconTheme,
      actionsIconTheme: widget.actionsIconTheme,
      textTheme: widget.textTheme,
      primary: widget.primary,
      centerTitle: widget.centerTitle,
      titleSpacing: widget.titleSpacing,
      bottomOpacity: widget.bottomOpacity,
      toolbarOpacity: widget.toolbarOpacity,
      shape: widget.shape,
    );
  }

  @override
  Widget build(BuildContext context) {
    backgroundColor = widget.backgroundColor ??
        Theme.of(context).appBarTheme.color ??
        Theme.of(context).primaryColor;

    elevation =
        widget.elevation ?? Theme.of(context).appBarTheme.elevation ?? 4.0;

    return StreamBuilder<bool>(
      stream: widget.scrollAppBarController.pinStream,
      builder: _pinBuilder,
    );
  }

  Widget _pinBuilder(
    BuildContext context,
    AsyncSnapshot<bool> pinSnapshot,
  ) {
    if (!pinSnapshot.hasData || pinSnapshot.data) {
      return _elevation(1.0);
    }
    return StreamBuilder(
      stream: widget.scrollAppBarController.heightFactorStream,
      builder: _heightFactorBuilder,
    );
  }

  Widget _heightFactorBuilder(
    BuildContext context,
    AsyncSnapshot<double> heightFactorSnapshot,
  ) {
    if (!heightFactorSnapshot.hasData) {
      return _elevation(1.0);
    }
    return _align(heightFactorSnapshot.data);
  }

  Widget _align(double heightFactor) {
    return Align(
      alignment: Alignment(0, 1),
      heightFactor: heightFactor,
      child: _elevation(heightFactor),
    );
  }

  Widget _elevation(double heightFactor) {
    return Material(
      elevation: elevation,
      child: _decoratedContainer(heightFactor),
    );
  }

  Widget _decoratedContainer(double heightFactor) {
    return Container(
      height: widget.scrollAppBarController.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: widget.backgroundGradient,
      ),
      child: _opacity(heightFactor),
    );
  }

  Widget _opacity(double heightFactor) {
    return Opacity(
      opacity: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ).transform(heightFactor),
      child: appBar,
    );
  }
}
