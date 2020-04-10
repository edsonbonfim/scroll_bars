import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scroll_bars_common/scroll_bars_common.dart';

class ScrollAppBarController extends ScrollBarsController {
  ScrollAppBarController({ScrollController scrollController})
      : super(scrollController: scrollController);

  @override
  double height = kToolbarHeight + (kIsWeb ? 0.0 : 24.0);
}
