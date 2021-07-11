import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';

class PinUnpinPage extends StatelessWidget {
  PinUnpinPage({Key? key}) : super(key: key);

  final controller = ScrollController();

  static const _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Page 1",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Page 2",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Basic")),
      body: ValueListenableBuilder<int>(
        valueListenable: controller.bottomNavigationBar.tabNotifier,
        child: SizedBox(height: MediaQuery.of(context).size.height * 2),
        builder: (context, pageIndex, child) => ListView(
          key: PageStorageKey(pageIndex),
          controller: controller, // Note the controller here
          children: [child!],
        ),
      ),
      bottomNavigationBar: ScrollBottomNavigationBar(
        controller: controller, // Controller is also here
        items: _items,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.bottomNavigationBar.isPinned) {
            controller.bottomNavigationBar.setPinState(false);
          } else {
            controller.bottomNavigationBar.setPinState(true);
          }
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: controller.bottomNavigationBar.pinNotifier,
          child: const Icon(Icons.push_pin),
          builder: (context, value, child) {
            if (!value) return child!;
            return Transform.rotate(angle: pi / 2, child: child);
          },
        ),
      ),
    );
  }
}
