import 'package:get/get.dart';
import 'package:notes_app/pages/add_note.dart';
import 'package:notes_app/pages/home_page.dart';

class AppRoutes {
  static const String initial = '/';
  static const String homePage = '/homePage';
  static const String addNote = '/addNote';

  static String get getInitial => initial;

  static String get getHomePage => homePage;

  static String get getAddNote => addNote;

  static List<GetPage> pages = [
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(name: homePage, page: () => const HomePage()),
    GetPage(
      name: addNote,
      page: () => AddNote(),
      transition: Transition.downToUp,
    ),
  ];
}
