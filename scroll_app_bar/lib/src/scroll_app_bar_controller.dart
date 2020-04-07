import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scroll_bars_common/scroll_bars_common.dart';

class ScrollAppBarController extends ScrollBarsController {
  ScrollAppBarController({ScrollController scrollController})
      : super(scrollController: scrollController);

  @override
  double get height {
    double paddingTop = 0.0;

    try {
      if (Platform.isAndroid || Platform.isFuchsia) paddingTop = 24.0;
    } catch (e) {}

    return kToolbarHeight + paddingTop;
  }
}
