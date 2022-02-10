import 'package:desafio_todo_list_value_notifier/src/todo/models/todo_model.dart';

abstract class TodoState {
  const TodoState();
}

class EmptyTodoState extends TodoState {}

class LoadingTodoState extends TodoState {}

class ErrorTodoState extends TodoState {
  final String message;

  ErrorTodoState(this.message);
}

class SucessTodoState extends TodoState {
  final List<TodoModel> todo;

  SucessTodoState(this.todo);
}

class SucessAddTodoState extends TodoState {
  // final Widget todo;
  // SucessAddTodoState({
  //   required this.todo,
  // });
}
