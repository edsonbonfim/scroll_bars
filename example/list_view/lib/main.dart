import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';

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
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollBottomNavigationBarController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollBottomNavigationBarController()..pageListener(onTap);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scaffoldKey.currentState.showSnackBar(SnackBar(
    //     content: Text("Snackbar support"),
    //     duration: Duration(hours: Duration.hoursPerDay),
    //     action: SnackBarAction(
    //       label: "CLOSE",
    //       onPressed: () => scaffoldKey.currentState.hideCurrentSnackBar(),
    //     ),
    //   ));
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: ScrollBody(
        scrollBottomNavigationBarController: controller,
        autoAttachScrollController: false,
        builder: (context, index) => ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          controller: controller.scrollController,
          itemBuilder: container,
        ),
      ),
      bottomNavigationBar: ScrollBottomNavigationBar(
        scrollBottomNavigationBarController: controller,
        items: items,
      ),
      // floatingActionButton: pin,
    );
  }

  List<BottomNavigationBarItem> get items {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text("Home"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        title: Text("Settings"),
      ),
    ];
  }

  Widget container(BuildContext context, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50),
      color: Color(Random().nextInt(0xffffffff)),
      child: Center(child: Text("$index")),
    );
  }

  Widget get pin {
    return FloatingActionButton(
      onPressed: () => controller.tooglePin(),
      child: Icon(Icons.touch_app),
    );
  }

  void onTap(int index) {
    print("Tapped on $index");
  }
}
