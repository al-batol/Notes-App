import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GetBuilder<HomePageController>(
            builder: (ctr) => Center(
              child:
                  ElevatedButton(onPressed: () async {}, child: Text('press')),
            ),
          ),
        ],
      ),
    );
  }
}
