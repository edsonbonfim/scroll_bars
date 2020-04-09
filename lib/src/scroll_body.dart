import 'package:flutter/material.dart';

import 'scroll_bottom_navigation_bar_controller.dart';

class ScrollBody extends StatelessWidget {
  const ScrollBody({
    Key key,
    @required this.scrollBottomNavigationBarController,
    @required this.builder,
    this.autoAtachScrollController = true,
  }) : super(key: key);

  final ScrollBottomNavigationBarController scrollBottomNavigationBarController;
  final Widget Function(BuildContext context, int index) builder;
  final bool autoAtachScrollController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: scrollBottomNavigationBarController.pageStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (!snapshot.hasData) return builder(context, 0);
        if (autoAtachScrollController) {
          return SingleChildScrollView(
            controller: scrollBottomNavigationBarController.scrollController,
            child: builder(context, snapshot.data),
          );
        } else {
          return builder(context, snapshot.data);
        }
      },
    );
  }
}
