import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/components/note_container.dart';
import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/data/sql_database.dart';
import 'package:notes_app/helper/router_helper.dart';
import 'package:notes_app/utils/app_dimensions.dart';

import 'package:notes_app/models/note_model.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> items = controller.items
        .map(
          (String e) => PopupMenuItem(
            value: e,
            onTap: () {},
            child: Text(
              e,
              style: TextStyle(fontSize: 14.0.sp),
            ),
          ),
        )
        .toList();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              width: 100.0.wp,
              height: 10.0.hp,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0.wp),
                ),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 33.0.wp,
                  ),
                  SizedBox(
                    width: 32.0.wp,
                    child: Text(
                      'My Notes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 18.0.wp),
                  SizedBox(
                    width: 10.0.wp,
                    child: GestureDetector(
                        child: PopupMenuButton(
                      position: PopupMenuPosition.under,
                      onSelected: (value) {
                        Get.bottomSheet(
                          Container(
                            width: 100.0.wp,
                            height: 20.0.hp,
                            padding: EdgeInsets.only(top: 2.0.hp, left: 5.0.wp),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0.wp),
                                  topRight: Radius.circular(10.0.wp),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Order by date:',
                                      style: TextStyle(fontSize: 18.0.sp),
                                    ),
                                  ],
                                ),
                                ...controller.sortBy.map(
                                  (e) => GetBuilder<HomePageController>(
                                    builder: (ctr) {
                                      return RadioListTile(
                                        activeColor: Colors.red,
                                        value: e,
                                        controlAffinity:
                                            ListTileControlAffinity.platform,
                                        groupValue: ctr.sort,
                                        contentPadding: EdgeInsets.zero,
                                        selected: ctr.sort == e,
                                        title: Text(
                                          '$e',
                                          style: TextStyle(
                                            fontSize: 14.0.sp,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          ctr.sort = value as String;
                                          ctr.sortNotes(value);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                AppDimensions.responsiveWidth(20)),
                            bottomRight: Radius.circular(
                                AppDimensions.responsiveWidth(20))),
                      ),
                      icon: Icon(
                        Icons.menu_open,
                        size: 7.0.wp,
                      ),
                      itemBuilder: (BuildContext context) => items,
                    )),
                  ),
                ],
              ),
            ),
            GetBuilder<HomePageController>(
              builder: (ctr) => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ctr.notes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return LongPressDraggable(
                    data: ctr.notes[index],
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
                      onTap: () {
                        Get.toNamed(AppRoutes.getEditNote(true, index));
                      },
                      child: NoteContainer(
                        title: ctr.notes[index].title,
                        topic: ctr.notes[index].topic!,
                        formattedTime: ctr.notes[index].formattedTime!,
                      ),
                    ),
                    feedback: Opacity(
                      opacity: 0.8,
                      child: NoteContainer(
                        title: ctr.notes[index].title,
                        topic: ctr.notes[index].topic!,
                        formattedTime: ctr.notes[index].formattedTime!,
                      ),
                    ),
                  );
                },
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
                Get.toNamed(AppRoutes.getAddNote());
                // AppDatabase().deleteDb();
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
