import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scroll_bars_common/scroll_bars_common.dart';

class ScrollBottomNavigationBarController extends ScrollBarsController {
  ScrollBottomNavigationBarController({ScrollController scrollController})
      : super(scrollController: scrollController);

  @override
  double height = kBottomNavigationBarHeight;

  final _page$ = BehaviorSubject<int>.seeded(0);

  @Deprecated("pageListener method should been used instead")
  Stream<int> get stream => pageStream;

  Stream<int> get pageStream => _page$.stream;

  void changePage(int index) => _page$.add(index);

  StreamSubscription<int> pageListener(
    void Function(int) onData, {
    Function onError,
    void Function() onDone,
    bool cancelOnError,
  }) {
    return _page$.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}
