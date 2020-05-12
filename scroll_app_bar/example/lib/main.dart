import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final controller = ScrollController(); // Controller is required

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ScrollAppBar(
          controller: controller, // Note the controller here
          title: Text("App Bar"),
        ),
        body: Snap(
          controller: controller.appBar,
          child: ListView.builder(
            controller: controller, // Controller is also here
            itemBuilder: _listBuildItem,
          ),
        ),
      ),
    );
  }

  Widget _listBuildItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      color: Color(Random().nextInt(0xffffffff)),
      child: Center(child: Text("$index")),
    );
  }
}
