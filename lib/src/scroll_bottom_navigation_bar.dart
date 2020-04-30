import 'package:flutter/material.dart';

import 'scroll_bottom_navigation_bar_controller.dart';

class ScrollBottomNavigationBar extends StatefulWidget {
  final ScrollController controller;
  final List<BottomNavigationBarItem> items;
  final double elevation;
  final BottomNavigationBarType type;
  final Color fixedColor;
  final Color backgroundColor;
  final Gradient backgroundGradient;
  final double iconSize;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final IconThemeData selectedIconTheme;
  final IconThemeData unselectedIconTheme;
  final double selectedFontSize;
  final double unselectedFontSize;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  ScrollBottomNavigationBar({
    Key key,
    @required this.controller,
    @required this.items,
    this.elevation = 8.0,
    this.type,
    this.fixedColor,
    this.backgroundColor = Colors.transparent,
    this.backgroundGradient,
    this.iconSize = 24.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true,
    this.showUnselectedLabels,
  })  : assert(controller != null),
        super(key: key);

  @override
  _ScrollBottomNavigationBarState createState() =>
      _ScrollBottomNavigationBarState();
}

class _ScrollBottomNavigationBarState extends State<ScrollBottomNavigationBar> {
  Widget bottomNavigationBar;
  Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    if (widget.backgroundGradient == null) {
      backgroundColor = widget.backgroundColor ??
          Theme.of(context).canvasColor ??
          Colors.white;
    }

    return ValueListenableBuilder<int>(
      valueListenable: widget.controller.bottomNavigationBar.tabNotifier,
      builder: _tab,
    );
  }

  Widget _tab(BuildContext context, int index, Widget child) {
    bottomNavigationBar = BottomNavigationBar(
      onTap: widget.controller.bottomNavigationBar.setTab,
      currentIndex: index,
      items: widget.items,
      elevation: 0.0,
      type: widget.type,
      fixedColor: widget.fixedColor,
      backgroundColor: Colors.transparent,
      iconSize: widget.iconSize,
      selectedItemColor: widget.selectedItemColor,
      unselectedItemColor: widget.unselectedItemColor,
      selectedIconTheme: widget.selectedIconTheme,
      unselectedIconTheme: widget.unselectedIconTheme,
      selectedFontSize: widget.selectedFontSize,
      unselectedFontSize: widget.unselectedFontSize,
      selectedLabelStyle: widget.selectedLabelStyle,
      unselectedLabelStyle: widget.unselectedLabelStyle,
      showSelectedLabels: widget.showSelectedLabels,
    );

    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.bottomNavigationBar.pinNotifier,
      builder: _pin,
    );
  }

  Widget _pin(BuildContext context, bool isPinned, Widget child) {
    if (isPinned) return _align(1.0);

    return ValueListenableBuilder<double>(
      valueListenable: widget.controller.bottomNavigationBar.heightNotifier,
      builder: _height,
    );
  }

  Widget _height(BuildContext context, double height, Widget child) {
    return _align(height);
  }

  Widget _align(double heightFactor) {
    return Align(
      heightFactor: heightFactor,
      alignment: Alignment(0, -1),
      child: _elevation(heightFactor),
    );
  }

  Widget _elevation(double heightFactor) {
    return Material(
      elevation: widget.elevation,
      child: _decoratedContainer(heightFactor),
    );
  }

  Widget _decoratedContainer(double heightFactor) {
    return Container(
      height: widget.controller.bottomNavigationBar.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: widget.backgroundGradient,
      ),
      child: _opacity(heightFactor),
    );
  }

  Widget _opacity(double heightFactor) {
    return Opacity(
      opacity: heightFactor,
      child: bottomNavigationBar,
    );
  }
}
