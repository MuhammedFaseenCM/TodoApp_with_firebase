class NoteModel {
  String? id;
  String? title;
  bool? iscompleted;
  String? content;

  NoteModel({
    this.iscompleted,
    required this.id,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'isCompleted': iscompleted,
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        iscompleted: json['isCompleted']);
  }
}
