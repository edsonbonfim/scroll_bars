import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

abstract class ScrollBarsController {
  ScrollBarsController({this.scrollController}) {
    (scrollController ??= ScrollController()).addListener(_scrollListener);
  }

  double get height;

  ScrollController scrollController;

  // ==========================================
  // heightFactory$
  // ==========================================

  final _heightFactor$ = BehaviorSubject<double>.seeded(1.0);

  Stream<double> get heightFactorStream => _heightFactor$.stream;

  double _delta = 0.0, _oldOffset = 0.0;

  void _scrollListener() {
    ScrollPosition position = scrollController.position;
    double pixels = position.pixels;

    _delta = (_delta + pixels - _oldOffset).clamp(0.0, height);
    _oldOffset = pixels;

    if (position.axisDirection == AxisDirection.down &&
        position.extentAfter == 0.0) {
      if (_heightFactor$.stream.value == 0.0) return;
      return _heightFactor$.add(0.0);
    }

    if (position.axisDirection == AxisDirection.up &&
        position.extentBefore == 0.0) {
      if (_heightFactor$.stream.value == 1.0) return;
      return _heightFactor$.add(1.0);
    }

    if ((_delta == 0.0 && _heightFactor$.stream.value == 0.0) ||
        (_delta == height && _heightFactor$.stream.value == 1.0)) return;

    _heightFactor$.add(1.0 - _delta / height);
  }

  // ==========================================
  // pin$
  // ==========================================

  final _pin$ = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get pinStream => _pin$.stream;

  bool get isPinned => _pin$.value;

  void setPinState(bool pin) => _pin$.add(pin);

  void tooglePin() => setPinState(!_pin$.value);

  // ==========================================
  // Dispose
  // ==========================================

  void dispose() {
    _pin$.close();
    _heightFactor$.close();
  }
}
