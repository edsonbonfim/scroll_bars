import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scroll_bars_common/scroll_bars_common.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

extension ScrollAppBarControllerExt on ScrollController {
  static final _controllers = <int, _ScrollAppBarController>{};

  _ScrollAppBarController get appBar {
    if (_controllers.containsKey(this.hashCode)) {
      return _controllers[this.hashCode];
    }

    return _controllers[this.hashCode] = _ScrollAppBarController(this);
  }
}

class _ScrollAppBarController extends ScrollBarsController {
  _ScrollAppBarController(ScrollController scrollController)
      : assert(scrollController != null),
        super(scrollController);

  @override
  double height = kToolbarHeight + (kIsWeb ? 0.0 : Platform.isAndroid ? 24.0 : 0.0);
}
