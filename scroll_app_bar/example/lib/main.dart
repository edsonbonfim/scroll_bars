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
  ScrollAppBarController scrollAppBarController;

  @override
  void initState() {
    super.initState();
    scrollAppBarController = ScrollAppBarController();
  }

  @override
  void dispose() {
    scrollAppBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ScrollAppBar(
        scrollAppBarController: scrollAppBarController,
        title: Text("App Bar"),
      ),
      body: ListView.builder(
        controller: scrollAppBarController.scrollController,
        itemBuilder: _listBuildItem,
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
