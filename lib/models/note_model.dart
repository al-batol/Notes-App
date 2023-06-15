class NoteModel {
  int? _id;
  String? _title;
  String? _topic;

  String? _timeStamp;

  int? get id => _id;

  String? get title => _title;

  String? get topic => _topic;

  String? get timeStamp => _timeStamp;

  NoteModel(
      {required int id,
      required String title,
      required String topic,
      required String timeStamp}) {
    _id = id;
    _title = title;
    _topic = topic;
    _timeStamp = timeStamp;
  }

  NoteModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _topic = json['topic'];
    _timeStamp = json['timestamp'];
  }

  operator [](String name) {
    if (name == 'id') return _id;
    if (name == 'title') return _title;
    if (name == 'topic') return _topic;
    if (name == 'timestamp') return _timeStamp;
    return null;
  }

  void operator []=(String name, String value) {
    if (name == 'id') {
      _id = int.parse(value);
    }
    if (name == 'title') {
      _title = value;
    }
    if (name == 'topic') {
      _topic = value;
    }
    if (name == 'timestamp') {
      _timeStamp = value;
    }
  }
}
