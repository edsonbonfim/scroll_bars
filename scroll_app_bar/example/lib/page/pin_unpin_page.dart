import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class PinUnpinPage extends StatelessWidget {
  PinUnpinPage({Key? key}) : super(key: key);

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller, // Note the controller here
        title: const Text("Pin/unpin"),
      ),
      body: ListView(
        controller: controller, // Controller is also here
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 2,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (controller.appBar.isPinned) {
            controller.appBar.setPinState(false);
          } else {
            controller.appBar.setPinState(true);
          }
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: controller.appBar.pinNotifier,
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
