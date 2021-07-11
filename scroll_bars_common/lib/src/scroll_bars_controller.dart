import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Snap extends StatelessWidget {
  final ScrollBarsController controller;
  final Widget child;

  const Snap({
    Key? key,
    required this.controller,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: _onNotification,
      child: child,
    );
  }

  bool _onNotification(UserScrollNotification notification) {
    if (notification.direction == ScrollDirection.idle) {
      if ([0.0, 1.0].contains(controller._heightFactor)) {
        return true;
      }

      final offset = controller._heightFactor.round() == 1
          ? -controller._delta
          : controller.height - controller._delta;

      controller.scrollController.animateTo(
        controller.scrollController.offset + offset,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
    return true;
  }
}

abstract class ScrollBarsController {
  ScrollBarsController(this.scrollController) {
    scrollController.addListener(_scrollListener);
  }

  /// Height of the bar
  double get height;

  /// Scroll controller
  ScrollController scrollController;

  /// Notifier of the visible height factor of bar
  final heightNotifier = ValueNotifier<double>(1.0);

  /// Notifier of the pin state changes
  final pinNotifier = ValueNotifier<bool>(false);

  /// Returns [true] if the bar is pinned or [false] if the bar is not pinned
  bool get isPinned => pinNotifier.value;

  /// Set a new pin state
  void setPinState(bool state) => pinNotifier.value = state;

  /// Toogle the pin state
  void tooglePinState() => setPinState(!pinNotifier.value);

  double _delta = 0.0, _oldOffset = 0.0;

  double get _heightFactor => 1.0 - (_delta / height);

  void _scrollListener() {
    ScrollPosition position = scrollController.position;
    double pixels = position.pixels;

    _delta = (_delta + pixels - _oldOffset).clamp(0.0, height);
    _oldOffset = pixels;

    if (position.axisDirection == AxisDirection.down &&
        position.extentAfter == 0.0) {
      if (heightNotifier.value == 0.0) return;
      heightNotifier.value = 0.0;
      return;
    }

    if (position.axisDirection == AxisDirection.up &&
        position.extentBefore == 0.0) {
      if (heightNotifier.value == 1.0) return;
      heightNotifier.value = 1.0;
      return;
    }

    if ((_delta == 0.0 && heightNotifier.value == 0.0) ||
        (_delta == height && heightNotifier.value == 1.0)) return;

    heightNotifier.value = _heightFactor;
  }

  /// Discards resources
  void dispose() {
    pinNotifier.dispose();
    heightNotifier.dispose();
  }
}
