import 'package:get/get.dart';
import 'package:notes_app/pages/home_page.dart';

class AppRoutes {
  static const String initial = '/';
  static const String homePage = '/homePage';

  static String get getInitial => initial;

  static String get getHomePage => homePage;

  static List<GetPage> pages = [
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(name: homePage, page: () => const HomePage()),
  ];
}
