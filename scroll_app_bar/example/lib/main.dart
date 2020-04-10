import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollAppBarController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollAppBarController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        scrollAppBarController: controller,
        title: Text("App Bar"),
      ),
      body: ListView.builder(
        controller: controller.scrollController,
        itemBuilder: _listBuildItem,
      ),
      floatingActionButton: _pin,
    );
  }

  Widget _listBuildItem(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      color: Color(Random().nextInt(0xffffffff)),
      child: Center(child: Text("$index")),
    );
  }

  Widget get _pin {
    return FloatingActionButton(
      onPressed: () => controller.tooglePin(),
      child: Icon(Icons.touch_app),
    );
  }
}
