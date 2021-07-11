import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class BasicPage extends StatelessWidget {
  BasicPage({Key? key}) : super(key: key);

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller, // Note the controller here
        title: const Text("Basic"),
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
