import 'package:flutter/material.dart';

import 'scroll_bottom_navigation_bar_controller.dart';

class ScrollBottomNavigationBar extends StatefulWidget {
  ScrollBottomNavigationBar({
    Key? key,
    required this.controller,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.elevation,
    this.type,
    Color? fixedColor,
    this.backgroundColor,
    this.backgroundGradient,
    this.iconSize = 24.0,
    Color? selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme,
    this.unselectedIconTheme,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.materialType,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    this.mouseCursor,
    this.enableFeedback,
  })  : assert(items.length >= 2),
        assert(
          items.every((BottomNavigationBarItem item) => item.label != null),
          'Every item must have a non-null title or label',
        ),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(elevation == null || elevation >= 0.0),
        assert(iconSize >= 0.0),
        assert(
          selectedItemColor == null || fixedColor == null,
          'Either selectedItemColor or fixedColor can be specified, but not both',
        ),
        assert(selectedFontSize >= 0.0),
        assert(unselectedFontSize >= 0.0),
        selectedItemColor = selectedItemColor ?? fixedColor,
        super(key: key);

  final ScrollController controller;

  final List<BottomNavigationBarItem> items;

  final ValueChanged<int>? onTap;

  final int currentIndex;

  final double? elevation;

  final BottomNavigationBarType? type;

  Color? get fixedColor => selectedItemColor;

  final Color? backgroundColor;

  final Gradient? backgroundGradient;

  final double iconSize;

  final Color? selectedItemColor;

  final Color? unselectedItemColor;

  final IconThemeData? selectedIconTheme;

  final IconThemeData? unselectedIconTheme;

  final MaterialType? materialType;

  final TextStyle? selectedLabelStyle;

  final TextStyle? unselectedLabelStyle;

  final double selectedFontSize;

  final double unselectedFontSize;

  final bool? showUnselectedLabels;

  final bool? showSelectedLabels;

  final MouseCursor? mouseCursor;

  final bool? enableFeedback;

  @override
  _ScrollBottomNavigationBarState createState() =>
      _ScrollBottomNavigationBarState();
}

class _ScrollBottomNavigationBarState extends State<ScrollBottomNavigationBar> {
  Widget? bottomNavigationBar;

  double? elevation;

  Color? backgroundColor;

  @override
  void didUpdateWidget(covariant ScrollBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.controller.bottomNavigationBar.tabNotifier,
      builder: _tab,
    );
  }

  void _init() {
    final BottomNavigationBarThemeData bottomTheme =
        BottomNavigationBarTheme.of(context);

    elevation = widget.elevation ?? bottomTheme.elevation ?? 8.0;

    switch (_effectiveType) {
      case BottomNavigationBarType.fixed:
        backgroundColor = widget.backgroundColor ?? bottomTheme.backgroundColor;
        break;
      case BottomNavigationBarType.shifting:
        backgroundColor = widget.items[widget.currentIndex].backgroundColor;
        break;
    }
  }

  BottomNavigationBarType get _effectiveType {
    return widget.type ??
        BottomNavigationBarTheme.of(context).type ??
        (widget.items.length <= 3
            ? BottomNavigationBarType.fixed
            : BottomNavigationBarType.shifting);
  }

  Widget _tab(BuildContext context, int index, Widget? child) {
    bottomNavigationBar = BottomNavigationBar(
      items: widget.items,
      onTap: widget.controller.bottomNavigationBar.setTab,
      currentIndex: index,
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
      showUnselectedLabels: widget.showUnselectedLabels,
      mouseCursor: widget.mouseCursor,
      enableFeedback: widget.enableFeedback,
    );

    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.bottomNavigationBar.pinNotifier,
      builder: _pin,
    );
  }

  Widget _pin(BuildContext context, bool isPinned, Widget? child) {
    if (isPinned) return _align(1.0);

    return ValueListenableBuilder<double>(
      valueListenable: widget.controller.bottomNavigationBar.heightNotifier,
      builder: _height,
    );
  }

  Widget _height(BuildContext context, double height, Widget? child) {
    return _align(height);
  }

  Widget _align(double heightFactor) {
    return Align(
      heightFactor: heightFactor,
      alignment: const Alignment(0, -1),
      child: _elevation(heightFactor),
    );
  }

  Widget _elevation(double heightFactor) {
    return Material(
      elevation: elevation ?? 8.0,
      type: widget.materialType != null
          ? widget.materialType!
          : MaterialType.canvas,
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
