import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/components/note_container.dart';
import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/helper/router_helper.dart';
import 'package:notes_app/utils/app_dimensions.dart';

import '../data/sql_database.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
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
                      bottomLeft: Radius.circular(20.0.wp),
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
            GetBuilder<HomePageController>(
              builder: (ctr) => GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  ...ctr.notes.map(
                    (e) => LongPressDraggable(
                      child: NoteContainer(
                        title: e.title,
                        topic: e.topic!,
                      ),
                      feedback: Opacity(
                        opacity: 0.8,
                        child: NoteContainer(
                          title: e.title,
                          topic: e.topic!,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Get.toNamed(AppRoutes.getAddNote);
            // await AppDatabase().deleteDb();
          },
          child: Icon(
            Icons.add,
          )),
    );
  }
}
