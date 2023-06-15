import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_app/data/repo.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/utils/SqlQueries.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController {
  AppRepo appRepo;

  HomePageController({required this.appRepo});

  final List<NoteModel> _notes = <NoteModel>[];

  List<NoteModel> get notes => _notes;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleEditing = TextEditingController();
  final TextEditingController topicEditing = TextEditingController();

  bool _onDraggable = false;

  set dragState(bool isDragging) {
    _onDraggable = isDragging;
    update();
  }

  bool get onDraggable => _onDraggable;

  @override
  void onInit() async {
    await readData();
    update();
    super.onInit();
  }

  Future<void> readData() async {
    List<Map<String, dynamic>> allNotes =
        await appRepo.readData(SqlQueries.readDataSql());
    _notes.addAll(allNotes.map((e) => NoteModel.fromJson(e)).toList());
  }

  Future<void> insertData(String title, String topic) async {
    DateFormat format = DateFormat('MMM d, yyyy');
    String timeStamp = format.format(DateTime.now());
    Map<String, dynamic> note = {
      'id': getTheGreaterId(),
      'title': title,
      'topic': topic,
      'timestamp': timeStamp,
    };
    _notes.add(NoteModel.fromJson(note));
    await appRepo.insertData(SqlQueries.insertDataSql(title, topic, timeStamp));
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
      return temp + 1;
    } else {
      return 1;
    }
  }

  Future<void> updateDate(int index, String columnName, String newValue) async {
    _notes[index][columnName] = newValue;
    await appRepo.updateData(
        SqlQueries.updateDataSql(_notes[index].id!, columnName, newValue));
    update();
  }

  Future<void> deleteData(int id) async {
    _notes.removeWhere((element) => element.id == id);
    await appRepo.deleteData(SqlQueries.deleteDataSql(id));
    update();
  }

  void willEditPage(bool willEdit, int index) {
    if (willEdit) {
      NoteModel note = _notes[index];
      titleEditing.text = note.title!;
      topicEditing.text = note.topic!;
    }
  }
}
