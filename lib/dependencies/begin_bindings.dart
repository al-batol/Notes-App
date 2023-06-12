import 'package:get/get.dart';
import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/data/repo.dart';
import 'package:notes_app/data/sql_database.dart';

class BeginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => HomePageController(
            appRepo: AppRepo(appDatabase: Get.find<AppDatabase>())),
        fenix: true);
  }
}
