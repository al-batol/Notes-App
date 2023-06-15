import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/utils/app_dimensions.dart';

import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/models/note_model.dart';

class AddNote extends StatelessWidget {
  HomePageController homeCtr = Get.find<HomePageController>();
  bool willEdit;

  int index;

  AddNote({Key? key, this.willEdit = false, this.index = -1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (willEdit) {
      homeCtr.willEditPage(willEdit, index);
    }
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: homeCtr.formKey,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0.wp),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15.0.wp,
                      height: 10.0.hp,
                      child: IconButton(
                        onPressed: () async {
                          if (homeCtr.titleEditing.text.trim().isEmpty &&
                              homeCtr.topicEditing.text.trim().isEmpty) {
                            Get.back();
                          } else {
                            if (!willEdit) {
                              await homeCtr.insertData(
                                homeCtr.titleEditing.text,
                                homeCtr.topicEditing.text,
                              );
                            } else {
                              print(homeCtr.titleEditing.text);
                              print(homeCtr.topicEditing.text);
                              await homeCtr.updateDate(
                                index,
                                'title',
                                homeCtr.titleEditing.text,
                              );
                              await homeCtr.updateDate(
                                index,
                                'topic',
                                homeCtr.topicEditing.text,
                              );
                            }
                            homeCtr.titleEditing.clear();
                            homeCtr.topicEditing.clear();
                            Get.back();
                          }
                        },
                        icon: Icon(Icons.arrow_back,
                            size: AppDimensions.responsiveWidth(25)),
                      ),
                    ),
                    Container(
                      width: 85.0.wp,
                      height: 10.0.hp,
                      padding: EdgeInsets.only(
                        top: 2.0.hp,
                        left: 10.0.wp,
                        right: 20.0.wp,
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        controller: homeCtr.titleEditing,
                        style: TextStyle(fontSize: 16.0.sp),
                        decoration: InputDecoration(
                          hintText: 'Title',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 2.0.hp),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        width: 96.0.wp,
                        height: 85.0.hp,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                        ),
                        child: TextFormField(
                          controller: homeCtr.topicEditing,
                          style: TextStyle(fontSize: 14.0.sp),
                          maxLines: AppDimensions.responsiveHeight(30).toInt(),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.0.hp,
                      ),
                      Container(
                        width: 96.0.wp,
                        height: 85.0.hp,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                        ),
                        child: TextFormField(
                          controller: homeCtr.topicEditing,
                          style: TextStyle(fontSize: 14.0.sp),
                          maxLines: AppDimensions.responsiveHeight(30).toInt(),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
