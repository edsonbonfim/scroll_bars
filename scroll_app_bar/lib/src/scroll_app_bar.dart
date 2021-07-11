import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'scroll_app_bar_controller.dart';

class ScrollAppBar extends StatefulWidget with PreferredSizeWidget {
  ScrollAppBar(
      {Key? key,
      required this.controller,
      this.leading,
      this.automaticallyImplyLeading = true,
      this.title,
      this.actions,
      this.flexibleSpace,
      this.bottom,
      this.elevation,
      this.shadowColor,
      this.shape,
      this.backgroundColor,
      this.foregroundColor,
      this.backgroundGradient,
      this.brightness,
      this.iconTheme,
      this.actionsIconTheme,
      this.textTheme,
      this.primary = true,
      this.centerTitle,
      this.excludeHeaderSemantics = false,
      this.titleSpacing,
      this.toolbarOpacity = 1.0,
      this.bottomOpacity = 1.0,
      this.toolbarHeight,
      this.leadingWidth,
      this.backwardsCompatibility,
      this.toolbarTextStyle,
      this.titleTextStyle,
      this.systemOverlayStyle,
      this.materialType})
      : assert(elevation == null || elevation >= 0.0),
        preferredSize = Size.fromHeight(toolbarHeight ??
            kToolbarHeight + (bottom?.preferredSize.height ?? 0.0)),
        super(key: key);

  final ScrollController controller;

  final Widget? leading;

  final bool automaticallyImplyLeading;

  final Widget? title;

  final List<Widget>? actions;

  final Widget? flexibleSpace;

  final PreferredSizeWidget? bottom;

  final double? elevation;

  final Color? shadowColor;

  final ShapeBorder? shape;

  final Color? backgroundColor;

  final Gradient? backgroundGradient;

  final Color? foregroundColor;

  final Brightness? brightness;

  final IconThemeData? iconTheme;

  final IconThemeData? actionsIconTheme;

  final TextTheme? textTheme;

  final bool primary;

  final bool? centerTitle;

  final bool excludeHeaderSemantics;

  final double? titleSpacing;

  final double toolbarOpacity;

  final double bottomOpacity;

  @override
  final Size preferredSize;

  final double? toolbarHeight;

  final double? leadingWidth;

  final bool? backwardsCompatibility;

  final TextStyle? toolbarTextStyle;

  final TextStyle? titleTextStyle;

  final SystemUiOverlayStyle? systemOverlayStyle;

  final MaterialType? materialType;

  @override
  _ScrollAppBarState createState() => _ScrollAppBarState();
}

class _ScrollAppBarState extends State<ScrollAppBar> {
  double? elevation;

  Color? backgroundColor;

  @override
  void didUpdateWidget(covariant ScrollAppBar oldWidget) {
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
    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.appBar.pinNotifier,
      builder: _pin,
      child: _appBar,
    );
  }

  void _init() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final AppBarTheme appBarTheme = AppBarTheme.of(context);

    final bool backwardsCompatibility = widget.backwardsCompatibility ??
        appBarTheme.backwardsCompatibility ??
        true;

    elevation = widget.elevation ?? appBarTheme.elevation ?? 4.0;

    backgroundColor = backwardsCompatibility
        ? widget.backgroundColor ??
            appBarTheme.backgroundColor ??
            theme.primaryColor
        : widget.backgroundColor ??
            appBarTheme.backgroundColor ??
            (colorScheme.brightness == Brightness.dark
                ? colorScheme.surface
                : colorScheme.primary);
  }

  Widget _pin(BuildContext context, bool isPinned, Widget? child) {
    if (isPinned) return _align(1.0, child);

    return ValueListenableBuilder<double>(
      valueListenable: widget.controller.appBar.heightNotifier,
      builder: _height,
      child: child,
    );
  }

  Widget _height(BuildContext context, double height, Widget? child) {
    return _align(height, child);
  }

  Widget _align(double heightFactor, Widget? child) {
    return Align(
      alignment: const Alignment(0, 1),
      heightFactor: heightFactor,
      child: _elevation(heightFactor, child),
    );
  }

  Widget _elevation(double heightFactor, Widget? child) {
    return Material(
      elevation: elevation ?? 4.0,
      type: widget.materialType != null
          ? widget.materialType!
          : MaterialType.canvas,
      child: _decoratedContainer(heightFactor, child),
    );
  }

  Widget _decoratedContainer(double heightFactor, Widget? child) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: widget.backgroundGradient,
      ),
      child: _opacity(heightFactor, child),
    );
  }

  Widget _opacity(double heightFactor, Widget? child) {
    return Opacity(
      opacity: const Interval(
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
      shadowColor: widget.shadowColor,
      shape: widget.shape,
      backgroundColor: Colors.transparent,
      foregroundColor: widget.foregroundColor,
      brightness: widget.brightness,
      iconTheme: widget.iconTheme,
      actionsIconTheme: widget.actionsIconTheme,
      textTheme: widget.textTheme,
      primary: widget.primary,
      centerTitle: widget.centerTitle,
      excludeHeaderSemantics: widget.excludeHeaderSemantics,
      titleSpacing: widget.titleSpacing,
      toolbarOpacity: widget.toolbarOpacity,
      bottomOpacity: widget.bottomOpacity,
      toolbarHeight: widget.toolbarHeight,
      leadingWidth: widget.leadingWidth,
      backwardsCompatibility: widget.backwardsCompatibility,
      toolbarTextStyle: widget.toolbarTextStyle,
      titleTextStyle: widget.titleTextStyle,
      systemOverlayStyle: widget.systemOverlayStyle,
    );
  }
}
