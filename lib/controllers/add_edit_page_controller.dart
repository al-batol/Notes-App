import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/models/note_model.dart';

import 'package:notes_app/utils/app_dimensions.dart';

class AddEditCtr extends GetxController {
  late int lines;
  final TextEditingController titleEditing = TextEditingController();
  final TextEditingController topicEditing = TextEditingController();

  @override
  void dispose() async {
    titleEditing.dispose();
    topicEditing.dispose();
    super.dispose();
  }

  void willEditPage(bool willEdit, NoteModel? note) {
    calculatePageSize(AppDimensions.fontSize);
    if (willEdit) {
      titleEditing.text = note!.title!;
      topicEditing.text = note.topic!;
      if (topicEditing.text.split('\n').length < lines) {
        final int fillLines = lines - topicEditing.text.split('\n').length;
        topicEditing.text += '\n' * fillLines;
      }
    } else {
      topicEditing.text = '\n' * lines;
      topicEditing.selection =
          TextSelection.fromPosition(const TextPosition(offset: 0));
    }
  }

  void calculatePageSize(double fonSize) {
    lines = (AppDimensions.height / (AppDimensions.fontSize * 2)).round();
  }

  Future<void> checkFields(BuildContext context, HomePageController homeCtr,
      bool willEdit, int index) async {
    if (titleEditing.text.trim().isEmpty && topicEditing.text.trim().isEmpty) {
    } else {
      if (!willEdit) {
        await homeCtr.insertData(
          titleEditing.text.trim(),
          topicEditing.text.trimRight(),
        );
      } else {
        print(3);
        await homeCtr.updateDate(
          index,
          'title',
          titleEditing.text,
        );
        await homeCtr.updateDate(
          index,
          'topic',
          topicEditing.text.trimRight(),
        );
      }
    }

    titleEditing.clear();
    topicEditing.clear();
  }
}
