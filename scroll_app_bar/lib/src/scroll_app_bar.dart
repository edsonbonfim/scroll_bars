import 'package:flutter/material.dart';

import 'scroll_app_bar_controller.dart';

class ScrollAppBar extends StatefulWidget with PreferredSizeWidget {
  ScrollAppBar({
    Key key,
    @required this.controller,
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
    this.centerTitle,
    this.titleSpacing = NavigationToolbar.kMiddleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.materialType,
  })  : assert(controller != null),
        super(key: key);

  final ScrollController controller;
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
  final bool centerTitle;
  final double titleSpacing;
  final ShapeBorder shape;
  final double bottomOpacity;
  final double toolbarOpacity;
  final MaterialType materialType;

  @override
  _ScrollAppBarState createState() => _ScrollAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ScrollAppBarState extends State<ScrollAppBar> {
  double elevation;
  Color backgroundColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    elevation =
        widget.elevation ?? Theme.of(context).appBarTheme.elevation ?? 4.0;

    backgroundColor = widget.backgroundColor ??
        Theme.of(context).appBarTheme.color ??
        Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.appBar.pinNotifier,
      builder: _pin,
      child: _appBar,
    );
  }

  Widget _pin(BuildContext context, bool isPinned, Widget child) {
    if (isPinned) return _align(1.0, child);

    return ValueListenableBuilder<double>(
      valueListenable: widget.controller.appBar.heightNotifier,
      builder: _height,
      child: child,
    );
  }

  Widget _height(BuildContext context, double height, Widget child) {
    return _align(height, child);
  }

  Widget _align(double heightFactor, Widget child) {
    return Align(
      alignment: Alignment(0, 1),
      heightFactor: heightFactor,
      child: _elevation(heightFactor, child),
    );
  }

  Widget _elevation(double heightFactor, Widget child) {
    return Material(
      elevation: elevation,
      type: widget.materialType != null
          ? widget.materialType
          : MaterialType.canvas,
      child: _decoratedContainer(heightFactor, child),
    );
  }

  Widget _decoratedContainer(double heightFactor, Widget child) {
    return Container(
      height: widget.controller.appBar.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: widget.backgroundGradient,
      ),
      child: _opacity(heightFactor, child),
    );
  }

  Widget _opacity(double heightFactor, Widget child) {
    return Opacity(
      opacity: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ).transform(heightFactor),
      child: child,
    );
  }

  Widget get _appBar {
    return AppBar(
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
      centerTitle: widget.centerTitle,
      titleSpacing: widget.titleSpacing,
      bottomOpacity: widget.bottomOpacity,
      toolbarOpacity: widget.toolbarOpacity,
      shape: widget.shape,
    );
  }
}
