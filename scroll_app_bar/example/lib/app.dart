import 'package:flutter/material.dart';

import 'page/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Scroll App Bar",
      home: HomePage(),
    );
  }
}
