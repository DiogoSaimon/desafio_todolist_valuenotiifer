import 'package:desafio_todo_list_value_notifier/src/todo/add_todo_page.dart';
import 'package:flutter/material.dart';
import 'todo/todo_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TodoList + ValueNotifier",
        home: const TodoPage(),
        routes: {
          "home": (context) => const TodoPage(),
          "add": (context) => const AddTodoPage(),
        });
  }
}
