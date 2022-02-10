import 'package:dio/dio.dart';
import 'package:desafio_todo_list_value_notifier/src/todo/models/todo_model.dart';

class TodoService {
  final Dio dio;
  final String _url = "http://localhost:3031/todo";
  TodoService(
    this.dio,
  );

  Future<List<TodoModel>> getAllTodo() async {
    final response = await dio.get(_url);
    List list = response.data;
    final todos = list.map(TodoModel.fromJson).toList();
    return todos;
  }

  Future<dynamic> postTodo(TodoModel todo) async {
    var response = await dio.post(_url, data: todo.toMap());
    return response.data;
  }

  Future<dynamic> putTodo(TodoModel todo) async {
    var response = await dio.put("$_url/${todo.id}", data: todo.toMap());
    return response.data;
  }

  Future<dynamic> removeTodo(TodoModel todo) async {
    var response = await dio.delete("$_url/${todo.id}");
    var todos = response.data;
    return todos;
  }
}
