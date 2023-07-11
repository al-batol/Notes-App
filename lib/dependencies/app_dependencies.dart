import 'package:get/get.dart';
import 'package:notes_app/controllers/add_edit_page_controller.dart';
import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/data/repo.dart';
import 'package:notes_app/data/sql_database.dart';

import 'package:notes_app/controllers/settings_controller.dart';
import 'package:notes_app/utils/app_dimensions.dart';

Future<void> dependencies() async {
  Get.lazyPut(
          () => HomePageController(
          appRepo: AppRepo(appDatabase: Get.find<AppDatabase>())));
  Get.lazyPut(() => SettingsController(appRepo: AppRepo(appDatabase: Get.find<AppDatabase>())));
  Get.lazyPut(() => AddEditCtr());
  SettingsController settingsCtr = Get.find<SettingsController>();
  HomePageController homePageCtr = Get.find<HomePageController>();
  AddEditCtr addEditCtr = Get.find<AddEditCtr>();
  await settingsCtr..getThemeMode();
  await settingsCtr.getLastTheme();
  await settingsCtr.getLang();
  await homePageCtr.readData();
  addEditCtr.calculatePageSize(AppDimensions.fontSize);
  homePageCtr.getColors(settingsCtr.themeMode);
}