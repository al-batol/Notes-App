import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:notes_app/utils/SqlQueries.dart';

class AppDatabase extends GetxService {
  Database? _database;


  Future<AppDatabase> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'app_notes.db');
    bool isExist = await databaseExists(path);
    if (isExist) {
      _database = await openDatabase(path);
    } else {
      _database = await openDatabase(path, onCreate: _onCreate, version: 1);
    }
    return this;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute(SqlQueries.createTable());
    batch.commit();
  }

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    return await _database!.rawQuery(sql);
  }

  Future<void> insertData(String sql) async {
    await _database!.rawInsert(sql);
  }

  Future<void> updateData(String sql) async {
    await _database!.rawUpdate(sql);
  }

  Future<void> deleteData(String sql) async {
   await _database!.rawDelete(sql);
  }
  Future<void> deleteDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'app_notes.db');
    deleteDatabase(path);
  }
}
