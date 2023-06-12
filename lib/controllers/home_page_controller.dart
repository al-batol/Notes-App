import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_app/data/repo.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/utils/SqlQueries.dart';

class HomePageController extends GetxController {
  AppRepo appRepo;

  HomePageController({required this.appRepo});

  final List<NoteModel> _notes = <NoteModel>[];

  List<NoteModel> get notes => _notes;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleEditing = TextEditingController();
  final TextEditingController topicEditing = TextEditingController();

  bool onDraggable = false;
  @override
  void onInit() {
    readData();
    super.onInit();
  }

  void readData() async {
    List<Map<String, dynamic>> allNotes =
        await appRepo.readData(SqlQueries.readDataSql());
    _notes.addAll(allNotes.map((e) => NoteModel.fromJson(e)).toList());
  }

  Future<void> insertData(String title, String topic) async {
    Map<String, dynamic> note = {
      'title': title,
      'topic': topic,
      'id': _notes.isEmpty ? 1 : getTheGreaterId() + 1
    };
    _notes.add(NoteModel.fromJson(note));
    await appRepo.insertData(SqlQueries.insertDataSql(title, topic));
    update();
  }

  int getTheGreaterId() {
    if (_notes.isNotEmpty) {
      int temp = _notes[0].id!;
      for (int i = 0; i < _notes.length; i++) {
        if (temp < _notes[i].id!) {
          temp = _notes[i].id!;
        }
      }
      return temp;
    } else {
      return 1;
    }
  }

  Future<void> updateDate(String id, String columnName, String newValue) async {
    await appRepo
        .updateData(SqlQueries.updateDataSql(id, columnName, newValue));
  }

  Future<void> deleteData(int id) async {
    _notes.removeWhere((element) => element.id == id);
    await appRepo.deleteData(SqlQueries.deleteDataSql(id.toString()));
    update();
  }
}
