import 'package:desafio_todo_list_value_notifier/src/todo/models/todo_model.dart';
import 'package:desafio_todo_list_value_notifier/src/todo/services/todo_service.dart';
import 'package:desafio_todo_list_value_notifier/src/todo/store/todo_store.dart';
import 'package:desafio_todo_list_value_notifier/src/todo/todo_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'src/app_widget.dart';

void main() {
  final di = GetIt.instance;

  di.registerFactory(() => Dio());
  di.registerFactory(() => TodoModel());
  di.registerFactory(() => const TodoPage());
  di.registerFactory(() => TodoService(di.get()));
  di.registerLazySingleton(() => TodoStore(di.get()));
  runApp(const AppWidget());
}
