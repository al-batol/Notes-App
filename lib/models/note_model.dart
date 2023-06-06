class NoteModel {
  int? _id;
  String? _title;
  String? _topic;

  int? get id => _id;

  String? get title => _title;

  String? get topic => _topic;

  NoteModel({required int id, required String title, required String topic}) {
    _id = id;
    _title = title;
    _topic = topic;
  }

  NoteModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _topic = json['topic'];
  }



  @override
  bool operator ==(Object other) =>
      other is NoteModel &&
          other.runtimeType == runtimeType &&
          other._id == _id &&
          _title == other._title &&
          _topic == other._topic  ;

  @override
  int get hashCode => _id.hashCode ^ _title.hashCode ^ _topic.hashCode;
}
