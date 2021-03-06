import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class PinUnpinPage extends StatefulWidget {
  @override
  _PinUnpinPageState createState() => _PinUnpinPageState();
}

class _PinUnpinPageState extends State<PinUnpinPage> {
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.appBar.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller, // Note the controller here
        title: Text("Snap"),
      ),
      body: Snap(
        controller: controller.appBar,
        child: ListView.builder(
          controller: controller, // Controller is also here
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text('$index'),
              ),
            );
          },
        ),
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
          child: Icon(Icons.push_pin),
          builder: (context, value, child) {
            if (!value) return child;
            return Transform.rotate(angle: pi / 2, child: child);
          },
        ),
      ),
    );
  }
}
