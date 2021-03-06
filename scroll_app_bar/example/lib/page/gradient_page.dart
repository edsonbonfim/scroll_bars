import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class GradientPage extends StatefulWidget {
  @override
  _GradientPageState createState() => _GradientPageState();
}

class _GradientPageState extends State<GradientPage> {
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
        backgroundGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue,
            Colors.green,
          ],
        ),
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
