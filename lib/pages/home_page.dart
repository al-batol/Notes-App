import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/utils/app_dimensions.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Container(
                width: 100.0.wp,
                height: 10.0.hp,
                padding: EdgeInsets.only(
                  top: 3.0.hp,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                  ),
                ),
                child: Text(
                  'My Notes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
