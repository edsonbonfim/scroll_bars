import 'package:flutter/material.dart';

import 'scroll_bottom_navigation_bar_controller.dart';

class ScrollBody extends StatelessWidget {
  const ScrollBody({
    Key key,
    @required this.scrollBottomNavigationBarController,
    @required this.builder,
    this.autoAttachScrollController = true,
  }) : super(key: key);

  final ScrollBottomNavigationBarController scrollBottomNavigationBarController;
  final Widget Function(BuildContext context, int index) builder;
  final bool autoAttachScrollController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: scrollBottomNavigationBarController.pageStream,
      builder: _pageBuilder,
    );
  }

  Widget _pageBuilder(BuildContext context, AsyncSnapshot<int> pageSnapshot) {
    return autoAttachScrollController
        ? _attach(context, pageSnapshot?.data ?? 0)
        : builder(context, pageSnapshot?.data ?? 0);
  }

  Widget _attach(BuildContext context, int index) {
    return SingleChildScrollView(
      controller: scrollBottomNavigationBarController.scrollController,
      child: builder(context, index),
    );
  }
}
