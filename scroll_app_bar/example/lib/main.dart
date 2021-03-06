import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final controller = ScrollController();

  bool notification;

  @override
  void initState() {
    super.initState();
    notification = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ScrollAppBar(
          controller: controller, // Note the controller here
          title: Text("App Bar"),
          backgroundColor:
              Colors.transparent, // Will make background transparent
          materialType: MaterialType
              .transparency, // Needed if you want a transparent background
          actions: [
            IconButton(
              icon: Icon(
                notification ? Icons.notifications : Icons.notifications_off,
              ),
              onPressed: () {
                setState(() => notification = !notification);
              },
            ),
          ],
        ),
        body: Snap(
          controller: controller.appBar,
          child: ListView.builder(
            controller: controller, // Controller is also here
            itemBuilder: _listBuildItem,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
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
