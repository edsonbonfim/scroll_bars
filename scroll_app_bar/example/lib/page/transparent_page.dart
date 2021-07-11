import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class TransparentPage extends StatelessWidget {
  TransparentPage({Key? key}) : super(key: key);

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller, // Note the controller here
        iconTheme: ThemeData.light().iconTheme,
        title: const Text(
          "Transparent Background",
          style: TextStyle(color: Colors.black),
        ),
        materialType: MaterialType.transparency,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        controller: controller, // Controller is also here
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 2,
          ),
        ],
      ),
    );
  }
}
