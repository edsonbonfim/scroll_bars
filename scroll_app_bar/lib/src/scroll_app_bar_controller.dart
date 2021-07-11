import 'package:flutter/material.dart';
import 'package:scroll_bars_common/scroll_bars_common.dart';

extension ScrollAppBarControllerExt on ScrollController {
  static final _controllers = <int, _ScrollAppBarController>{};

  _ScrollAppBarController get appBar {
    if (_controllers.containsKey(hashCode) &&
        _controllers[hashCode] is _ScrollAppBarController) {
      return _controllers[hashCode]!;
    }

    return _controllers[hashCode] = _ScrollAppBarController(this);
  }

  bottom({
    double? toolbarHeight,
    double? preferredSizeHeight,
  }) {
    _controllers[hashCode] = _ScrollAppBarController(
      this,
      toolbarHeight: toolbarHeight,
      preferredSizeHeight: preferredSizeHeight,
    );
  }
}

class _ScrollAppBarController extends ScrollBarsController {
  _ScrollAppBarController(
    ScrollController scrollController, {
    this.toolbarHeight,
    this.preferredSizeHeight,
  })  : height = toolbarHeight ?? kToolbarHeight + (preferredSizeHeight ?? 0.0),
        super(scrollController);

  final double? toolbarHeight;

  final double? preferredSizeHeight;

  @override
  double height;
}
