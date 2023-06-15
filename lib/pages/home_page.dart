import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/components/note_container.dart';
import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/helper/router_helper.dart';
import 'package:notes_app/utils/app_dimensions.dart';

import '../data/sql_database.dart';
import '../models/note_model.dart';

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
                      data: e,
                      onDragStarted: () {
                        ctr.dragState = true;
                      },
                      onDraggableCanceled: (_, __) {
                        ctr.dragState = false;
                      },
                      onDragEnd: (_) {
                        ctr.dragState = false;
                      },
                      child: GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.addNote);
                        },
                        child: NoteContainer(
                          title: e.title,
                          topic: e.topic!,
                          timeStamp: e.timeStamp!,
                        ),
                      ),
                      feedback: Opacity(
                        opacity: 0.8,
                        child: NoteContainer(
                          title: e.title,
                          topic: e.topic!,
                          timeStamp: e.timeStamp!,
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
      floatingActionButton: GetBuilder<HomePageController>(
        builder: (ctr) => DragTarget<NoteModel>(
          builder: (_, __, ___) => FloatingActionButton(
              backgroundColor: ctr.onDraggable ? Colors.red : Colors.blue,
              onPressed: () async {
                Get.toNamed(AppRoutes.getAddNote);
                // await AppDatabase().deleteDb();
                // ctr.deleteData(1);
              },
              child: Icon(
                ctr.onDraggable ? Icons.delete_forever : Icons.add,
              )),
          onAccept: (NoteModel note) async {
            await ctr.deleteData(note.id!);
          },
        ),
      ),
    );
  }
}
