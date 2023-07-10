import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:notes_app/utils/app_dimensions.dart';

import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/utils/app_style.dart';

import 'package:notes_app/controllers/settings_controller.dart';

class AddOrEditNote extends StatelessWidget {
  HomePageController homeCtr = Get.find<HomePageController>();
  SettingsController settingsCtr = Get.find<SettingsController>();
  final bool willEdit;

  final int index;

  AddOrEditNote({Key? key, this.willEdit = false, this.index = -1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width != 0.0) {
      AppDimensions.width = MediaQuery.of(context).size.width;
      AppDimensions.height = MediaQuery.of(context).size.height;
    }
    if (willEdit) {
      homeCtr.willEditPage(willEdit, index);
    } else {
      homeCtr.willEditPage(willEdit, index);
    }
    Orientation orientation = MediaQuery.of(context).orientation;
    homeCtr.getOrientation(orientation);
    if (homeCtr.isLandscape) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
          overlays: []);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    }
    if (MediaQuery.viewInsetsOf(context).bottom > 0.0 ||
        MediaQuery.viewInsetsOf(context).bottomRight > Offset(0, 0) ||
        MediaQuery.viewInsetsOf(context).bottomLeft > Offset(0, 0)) {
    }
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          resizeToAvoidBottomInset: false,

          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              GetBuilder<SettingsController>(
                builder: (ctr) => Container(
                  width: 80.0.wp,
                  height: homeCtr.isLandscape ? 25.0.hp : 15.0.hp,
                  padding: EdgeInsets.only(top: 5.0.hp),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: ctr.lang == 'en'
                          ? Radius.circular(20.0.wp)
                          : Radius.zero,
                      bottomLeft: ctr.lang == 'ar'
                          ? Radius.circular(20.0.wp)
                          : Radius.zero,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15.0.wp,
                        height: homeCtr.isLandscape ? 25.0.hp : 10.0.hp,
                        child: IconButton(
                          onPressed: () async {
                            if (homeCtr.titleEditing.text.trim().isEmpty &&
                                homeCtr.topicEditing.text.trim().isEmpty) {
                              Get.back();
                            } else {
                              if (!willEdit) {
                                await homeCtr.insertData(
                                  homeCtr.titleEditing.text,
                                  homeCtr.topicEditing.text.trimRight(),
                                );
                              } else {
                                await homeCtr.updateDate(
                                  index,
                                  'title',
                                  homeCtr.titleEditing.text,
                                );
                                await homeCtr.updateDate(
                                  index,
                                  'topic',
                                  homeCtr.topicEditing.text.trimRight(),
                                );
                              }
                              homeCtr.titleEditing.clear();
                              homeCtr.topicEditing.clear();
                              Get.back();
                            }
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: homeCtr.isLandscape ? 5.0.wp : 7.0.wp,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      Container(
                        width: homeCtr.isLandscape ? 62.0.wp : 65.0.wp,
                        height: homeCtr.isLandscape ? 25.0.hp : 10.0.hp,
                        padding: EdgeInsets.only(
                          top: homeCtr.isLandscape ? 2.0.hp : 1.0.hp,
                          left: homeCtr.isLandscape ? 0.0 : 10.0.wp,
                          right: homeCtr.isLandscape ? 0.0 : 20.0.wp,
                        ),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.top,
                          controller: homeCtr.titleEditing,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: homeCtr.isLandscape
                                  ? 11.0.sp
                                  : AppDimensions.fontSizeFixed.sp),
                          decoration: InputDecoration(
                            hintText: 'Ti'.tr,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .color!
                                        .withOpacity(0.5),
                                    fontSize: homeCtr.isLandscape
                                        ? 11.0.sp
                                        : AppDimensions.fontSizeFixed.sp),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
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
              SizedBox(height: 2.0.hp),
              GetBuilder<HomePageController>(
                builder: (ctr) => Container(
                  width: 80.0.wp,
                  child: TextFormField(
                    controller: homeCtr.topicEditing,
                    cursorColor: Color(DarkMode.cursorColor),
                    minLines: homeCtr.lines - 1,
                    maxLines: null,
                    autofocus: willEdit ? false : true,
                    mouseCursor: MaterialStateMouseCursor.textable,
                    onChanged: (value) {
                      if (homeCtr.topicEditing.text.split('\n').length <
                          homeCtr.lines * (index + 1)) {
                        final lastPosition =
                            homeCtr.topicEditing.selection.baseOffset;
                        final int fillLines = homeCtr.lines -
                            homeCtr.topicEditing.text.split('\n').length;
                        homeCtr.topicEditing.text += '\n' * fillLines;
                        homeCtr.topicEditing.selection = TextSelection.fromPosition(
                            TextPosition(offset: lastPosition));
                      } else {}
                    },
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: AppDimensions.fontSize),
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).primaryColor,
                      filled: true,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
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
