library scroll_bars_common;

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class ScrollBarsController {
  ScrollBarsController({
    this.scrollController,
  }) {
    scrollController ??= ScrollController();
    _scrollListener();
  }

  double get height;

  final _heightController = BehaviorSubject<double>.seeded(0.0);

  ScrollController scrollController;

  Stream<double> get heightStream => _heightController.stream;

  void _scrollListener() {
    double delta = 0.0, oldOffset = 0.0;

    scrollController.addListener(() {
      double offset = scrollController.offset;

      delta += (offset - oldOffset);

      if (delta > height) delta = height;
      if (delta < 0) delta = 0;

      oldOffset = offset;
      _heightController.add(delta);
    });
  }

  void dispose() {
    _heightController.close();
  }
}
