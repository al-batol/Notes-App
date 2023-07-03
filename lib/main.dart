import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/home_page_controller.dart';
import 'package:notes_app/data/sql_database.dart';
import 'package:notes_app/dependencies/app_dependencies.dart' as dep;
import 'package:notes_app/helper/router_helper.dart';
import 'package:notes_app/utils/app_style.dart';
import 'package:notes_app/utils/lang.dart';
import 'controllers/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AppDatabase().initDatabase());
  await dep.dependencies();
  runApp(const MyApp());
}

class MyApp extends GetView<SettingsController> {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      builder: (ctr) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initial,
        getPages: AppRoutes.pages,
        theme: Themes.customLightMode,
        darkTheme: Themes.customDarkMode,
        themeMode: controller.themeMode,
        locale: controller.locale,
        translations: AppLanguages(),
      ),
    );
  }
}
