library scroll_bottom_navigation_bar;

import 'dart:async';

import 'package:flutter/material.dart';

class _ScrollBottomNavigationBarScrollController {
  double _offset = 0.0, _delta = 0.0, _oldOffset = 0.0;

  ScrollController _scrollController;

  StreamController<double> _streamController;

  _ScrollBottomNavigationBarScrollController() {
    _streamController = StreamController<double>.broadcast()..add(0.0);

    _scrollController = ScrollController()
      ..addListener(() {
        double offset = _scrollController.offset;
        _delta += (offset - _oldOffset);
        if (_delta > kBottomNavigationBarHeight)
          _delta = kBottomNavigationBarHeight;
        else if (_delta < 0) _delta = 0;
        _oldOffset = offset;
        _offset = -_delta;
        _streamController.add(_offset);
      });
  }

  Stream<double> get stream => _streamController.stream;

  void dispose() {
    _streamController.close();
    _scrollController.dispose();
  }
}

class ScrollBottomNavigationBarController {
  final _streamController = StreamController<int>.broadcast()..add(0);

  final _bottomNavigationBarScrollController =
      _ScrollBottomNavigationBarScrollController();

  Stream<int> get stream => _streamController.stream;

  ScrollController get scrollController =>
      _bottomNavigationBarScrollController._scrollController;

  void dispose() {
    _bottomNavigationBarScrollController.dispose();
    _streamController.close();
  }
}

class ScrollBody extends StatelessWidget {
  final ScrollBottomNavigationBarController controller;
  final Widget Function(BuildContext context, int index) builder;
  final bool autoAtachScrollController;

  const ScrollBody({
    Key key,
    @required this.controller,
    @required this.builder,
    this.autoAtachScrollController = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: controller.stream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (autoAtachScrollController) {
          return SingleChildScrollView(
            controller: controller.scrollController,
            child: builder(context, !snapshot.hasData ? 0 : snapshot.data),
          );
        } else {
          return builder(context, !snapshot.hasData ? 0 : snapshot.data);
        }
      },
    );
  }
}

class ScrollBottomNavigationBar extends StatelessWidget {
  final ScrollBottomNavigationBarController controller;
  final List<BottomNavigationBarItem> items;
  final double elevation;
  final BottomNavigationBarType type;
  final Color fixedColor;
  final Color backgroundColor;
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
  final bool pinned;

  ScrollBottomNavigationBar({
    Key key,
    @required this.controller,
    @required this.items,
    this.elevation = 8.0,
    this.type,
    this.fixedColor,
    this.backgroundColor,
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
    this.pinned = false,
  })  : assert(controller != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: controller.stream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        var child = BottomNavigationBar(
          onTap: controller._streamController.add,
          currentIndex: !snapshot.hasData ? 0 : snapshot.data,
          items: items,
          elevation: elevation,
          type: type,
          fixedColor: fixedColor,
          backgroundColor: backgroundColor,
          iconSize: iconSize,
          selectedItemColor: selectedItemColor,
          unselectedItemColor: unselectedItemColor,
          selectedIconTheme: selectedIconTheme,
          unselectedIconTheme: unselectedIconTheme,
          selectedFontSize: selectedFontSize,
          unselectedFontSize: unselectedFontSize,
          selectedLabelStyle: selectedLabelStyle,
          unselectedLabelStyle: unselectedLabelStyle,
          showSelectedLabels: showSelectedLabels,
        );

        if (pinned) {
          return child;
        }

        return StreamBuilder<double>(
          stream: controller._bottomNavigationBarScrollController.stream,
          builder: (BuildContext context, AsyncSnapshot<double> scrollOffset) {
            return Transform.translate(
              offset: Offset(
                0.0,
                1.0 - (scrollOffset.hasData ? scrollOffset.data : 0.0),
              ),
              child: child,
            );
          },
        );
      },
    );
  }
}
