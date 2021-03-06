import 'package:flutter/material.dart';

import 'pin_unpin_page.dart';
import 'simple_scroll_page.dart';
import 'snap_scroll_page.dart';
import 'gradient_page.dart';
import 'transparent_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll app bar"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _button(
            text: "Simple scroll",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SimpleScrollPage();
              }));
            },
          ),
          _button(
            text: "Snap behavior",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SnapScrollPage();
              }));
            },
          ),
          _button(
            text: "Pin/unpin",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return PinUnpinPage();
              }));
            },
          ),
          _button(
            text: "Gradient background",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return GradientPage();
              }));
            },
          ),
          _button(
            text: "Transparent Background",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TransparentPage();
              }));
            },
          ),
        ],
      ),
    );
  }

  _button({String text, VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}
