import 'package:desafio_todo_list_value_notifier/src/todo/models/todo_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:desafio_todo_list_value_notifier/src/todo/services/todo_service.dart';
import 'package:desafio_todo_list_value_notifier/src/todo/states/todo_state.dart';

class TodoStore extends ValueNotifier<TodoState> {
  final TodoService service;
  TodoStore(
    this.service,
  ) : super(EmptyTodoState());

  isChecked(bool newValue) {
    var checked = newValue;
    return checked;
  }

  Future<void> fetchTodo() async {
    value = LoadingTodoState();
    try {
      var todo = await service.getAllTodo();
      value = SucessTodoState(todo);
    } catch (e) {
      value = ErrorTodoState(e.toString());
    }
  }

  Future<void> addTodo(TodoModel todo) async {
    value = LoadingTodoState();
    try {
      var sucess = await service.postTodo(todo);
      fetchTodo();
      value = SucessTodoState(sucess);
    } catch (e) {
      value = ErrorTodoState(e.toString());
    }
  }

  Future<void> updateTodo({String? id, String? title, String? message}) async {
    value = LoadingTodoState();

    TodoModel todo = TodoModel.fromMap({
      "id": id,
      "title": title,
      "message": message,
    });

    try {
      var sucess = await service.putTodo(todo);
      fetchTodo();
      value = SucessTodoState(sucess);
    } catch (e) {
      value = ErrorTodoState('A Tarefa não foi atualizada');
    }
  }

  Future<void> deleteTodo(TodoModel todo) async {
    value = LoadingTodoState();
    try {
      var sucess = await service.removeTodo(todo);
      fetchTodo();
      value = SucessTodoState(sucess);
    } catch (e) {
      value = ErrorTodoState(e.toString());
    }
  }
}
