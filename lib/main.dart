import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/data/sql_database.dart';
import 'package:notes_app/dependencies/begin_bindings.dart';
import 'package:notes_app/helper/router_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AppDatabase().initDatabase());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.pages,
      initialBinding: BeginBinding(),
    );
  }
}
