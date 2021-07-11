import 'package:flutter/material.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';

class TransparentPage extends StatelessWidget {
  TransparentPage({Key? key}) : super(key: key);

  final controller = ScrollController();

  static const _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Page 1",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Page 2",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transparent Background")),
      body: ValueListenableBuilder<int>(
        valueListenable: controller.bottomNavigationBar.tabNotifier,
        child: SizedBox(height: MediaQuery.of(context).size.height * 2),
        builder: (context, pageIndex, child) => ListView(
          key: PageStorageKey(pageIndex),
          controller: controller, // Note the controller here
          children: [child!],
        ),
      ),
      bottomNavigationBar: ScrollBottomNavigationBar(
        controller: controller, // Controller is also here
        items: _items,
        materialType: MaterialType.transparency,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
