import 'package:flutter/material.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ScrollBottomNavigationBarController _scrollBottomNavigationBarController;

  @override
  void initState() {
    super.initState();
    _scrollBottomNavigationBarController = ScrollBottomNavigationBarController()
      ..pages.listen(onTap);
  }

  @override
  void dispose() {
    _scrollBottomNavigationBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text("ScrollBottomNavigationBar"),
        ),
        body: ScrollBody(
          scrollBottomNavigationBarController:
              _scrollBottomNavigationBarController,
          autoAtachScrollController: false,
          builder: (context, index) => PageView.builder(
            key: UniqueKey(),
            itemBuilder: (context, page) => SingleChildScrollView(
              padding: EdgeInsets.zero,
              controller: _scrollBottomNavigationBarController.scrollController,
              child: Container(
                height: MediaQuery.of(context).size.height +
                    kBottomNavigationBarHeight -
                    kToolbarHeight,
                child: Center(
                  child: Text("PageView $index: $page"),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: ScrollBottomNavigationBar(
          scrollBottomNavigationBarController:
              _scrollBottomNavigationBarController,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.mood),
              title: Text("One"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mood),
              title: Text("Two"),
            ),
          ],
        ),
      ),
    );
  }

  void onTap(int index) {
    print("Tapped on $index");
  }
}
