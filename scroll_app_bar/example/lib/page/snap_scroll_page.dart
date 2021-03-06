import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class SnapScrollPage extends StatefulWidget {
  @override
  _SnapScrollPageState createState() => _SnapScrollPageState();
}

class _SnapScrollPageState extends State<SnapScrollPage> {
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
    );
  }
}
