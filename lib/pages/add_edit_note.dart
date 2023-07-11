import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/add_edit_page_controller.dart';
import 'package:notes_app/utils/app_dimensions.dart';

import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/utils/app_style.dart';

import 'package:notes_app/controllers/settings_controller.dart';

class AddOrEditNote extends GetView<AddEditCtr> {
  final SettingsController settingsCtr = Get.find<SettingsController>();
  final HomePageController homeCtr = Get.find<HomePageController>();
  final bool willEdit;

  final int index;

  AddOrEditNote({Key? key, this.willEdit = false, this.index = -1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    homeCtr.getOrientation(MediaQuery.orientationOf(context));

    return WillPopScope(
      onWillPop: () async {
        if (MediaQuery.viewInsetsOf(context).bottom > 0.0 ||
            MediaQuery.viewInsetsOf(context).bottomRight > Offset(0, 0) ||
            MediaQuery.viewInsetsOf(context).bottomLeft > Offset(0, 0)) {
          return true;
        } else {
          await controller.checkFields(context, homeCtr, willEdit, index);
            return true;
        }
      },
      child: GetBuilder<AddEditCtr>(
        builder: (Ctr) => SafeArea(
          top: homeCtr.isLandscape ? true : false,
          bottom: homeCtr.isLandscape ? true : false,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: ListView(
              padding: EdgeInsets.zero,
              children: [
                GetBuilder<SettingsController>(
                  builder: (ctr) => Container(
                    width: homeCtr.isLandscape ? 80.0.hp : 80.0.wp,
                    height: homeCtr.isLandscape ? 25.0.hp : 15.0.hp,
                    padding: EdgeInsets.only(top: homeCtr.isLandscape ? 5.0.wp : 5.0.hp),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: ctr.lang == 'en'
                            ? Radius.circular(homeCtr.isLandscape ? 20.0.hp : 20.0.wp)
                            : Radius.zero,
                        bottomLeft: ctr.lang == 'ar'
                            ? Radius.circular(homeCtr.isLandscape ? 20.0.hp : 20.0.wp)
                            : Radius.zero,
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: homeCtr.isLandscape ? 15.0.hp :15.0.wp,
                          height: homeCtr.isLandscape ? 25.0.hp : 10.0.hp,
                          child: IconButton(
                            onPressed: () async {
                              await controller.checkFields(context, homeCtr, willEdit, index);
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: homeCtr.isLandscape ? 7.0.hp : 7.0.wp,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                        Container(
                          width: homeCtr.isLandscape ? 65.0.hp : 65.0.wp,
                          height: homeCtr.isLandscape ? 10.0.wp : 10.0.hp,
                          padding: EdgeInsets.only(
                            top: homeCtr.isLandscape ? 1.0.wp : 1.0.hp,
                            left: homeCtr.isLandscape ? 0.0 : 10.0.wp,
                            right: homeCtr.isLandscape ? 0.0 : 20.0.wp,
                          ),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.top,
                            controller: controller.titleEditing,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
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
                    width: homeCtr.isLandscape ? 80.0.hp : 80.0.wp,
                    child: TextFormField(
                      controller: controller.topicEditing,
                      cursorColor: Color(DarkMode.cursorColor),
                      minLines: controller.lines - 1,
                      maxLines: null,
                      autofocus: willEdit ? false : true,
                      onChanged: (value) {
                        if (controller.topicEditing.text.split('\n').length <
                            controller.lines * (index + 1)) {
                          final lastPosition =
                              controller.topicEditing.selection.baseOffset;
                          final int fillLines = controller.lines -
                              controller.topicEditing.text.split('\n').length;
                          controller.topicEditing.text += '\n' * fillLines;
                          controller.topicEditing.selection =
                              TextSelection.fromPosition(
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
      ),
    );
  }
}
