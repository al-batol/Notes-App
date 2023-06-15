import 'dart:convert';

import 'package:get/get.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/pages/add_note.dart';
import 'package:notes_app/pages/home_page.dart';

class AppRoutes {
  static const String initial = '/';
  static const String homePage = '/homePage';
  static const String addNote = '/addNote';
  static const String editNote = '/editNote';

  static String getInitial () => initial;

  static String getHomePage () => homePage;

  static String  getAddNote() => addNote;

  static String getEditNote(bool willEdit, int index) =>
      '$editNote?willEdit=$willEdit&index=$index';

  static List<GetPage> pages = [
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(name: homePage, page: () => const HomePage()),
    GetPage(
      name: addNote,
      page: () {
        return AddNote(willEdit: false);
      },
      transition: Transition.downToUp,
    ),
    GetPage(
        name: editNote,
        page: () {
          bool willEdit = Get.parameters['willEdit'] == 'true';
          int index = int.parse(Get.parameters['index'].toString());
          return AddNote(willEdit: willEdit, index: index);
        })
  ];
}
