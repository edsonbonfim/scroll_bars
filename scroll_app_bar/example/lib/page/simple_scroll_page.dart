import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class SimpleScrollPage extends StatefulWidget {
  @override
  _SimpleScrollPageState createState() => _SimpleScrollPageState();
}

class _SimpleScrollPageState extends State<SimpleScrollPage> {
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
        title: Text("Simple"),
      ),
      body: ListView.builder(
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
    );
  }
}
