import 'package:flutter/material.dart';

import 'pin_unpin_page.dart';
import 'basic_page.dart';
import 'snap_page.dart';
import 'gradient_page.dart';
import 'transparent_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scroll Bottom Navigation Bar"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button("Basic", () => BasicPage()),
          _button("Snap", () => SnapPage()),
          _button("Pin/unpin", () => PinUnpinPage()),
          _button("Gradient Background", () => GradientPage()),
          _button("Transparent Background", () => TransparentPage()),
        ],
      ),
    );
  }

  _button(text, Widget Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return onPressed.call();
                    },
                  ),
                );
              },
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
