import 'dart:ui';

import 'package:flutter/material.dart';

import 'scroll_app_bar_controller.dart';

class ScrollAppBar extends StatelessWidget with PreferredSizeWidget {
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
    this.brightness,
    this.iconTheme,
    this.actionsIconTheme,
    this.textTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
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
  final Brightness brightness;
  final IconThemeData iconTheme;
  final IconThemeData actionsIconTheme;
  final TextTheme textTheme;
  final bool primary;
  final bool centerTitle;
  final bool excludeHeaderSemantics;
  final double titleSpacing;
  final ShapeBorder shape;
  final double bottomOpacity;
  final double toolbarOpacity;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      elevation: elevation,
      backgroundColor: backgroundColor,
      brightness: brightness,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      textTheme: textTheme,
      primary: primary,
      centerTitle: centerTitle,
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      bottomOpacity: bottomOpacity,
      toolbarOpacity: toolbarOpacity,
      shape: shape,
    );

    final color = appBar.backgroundColor ??
        Theme.of(context).appBarTheme.color ??
        Theme.of(context).primaryColor;

    return StreamBuilder<double>(
      stream: scrollAppBarController.heightStream,
      builder: (BuildContext context, AsyncSnapshot<double> height) {
        if (!height.hasData) return appBar;

        double opacity =
            (height.data / scrollAppBarController.height).clamp(0.0, 1.0);

        return Transform.translate(
          offset: Offset(0.0, -height.data),
          child: Container(
              height: scrollAppBarController.height,
              color: color,
              child: Opacity(
                opacity: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)
                    .transform(1.0 - opacity),
                child: appBar,
              )),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
