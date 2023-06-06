import 'package:notes_app/data/sql_database.dart';

class AppRepo {
  AppDatabase appDatabase;

  AppRepo({required this.appDatabase});

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    return await appDatabase.readData(sql);
  }

  Future<void> insertData(String sql) async {
    await appDatabase.insertData(sql);
  }

  Future<void> updateData(String sql) async {
    await appDatabase.updateData(sql);
  }

  Future<void> deleteData(String sql) async {
    await appDatabase.deleteData(sql);
  }
}
