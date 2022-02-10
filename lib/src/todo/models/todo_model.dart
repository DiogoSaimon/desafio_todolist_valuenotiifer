import 'dart:convert';

class TodoModel {
  String? id;
  String? title;
  String? message;

  TodoModel({
    this.id,
    this.title,
    this.message,
  });

  @override
  String toString() => 'TodoModel(id: $id, title: $title, message: $message)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(dynamic json) {
    return TodoModel(
      id: json["id"],
      title: json["title"],
      message: json["message"],
    );
  }
}
