import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:desafio_todo_list_value_notifier/src/todo/models/todo_model.dart';
import 'package:desafio_todo_list_value_notifier/src/todo/store/todo_store.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({
    Key? key,
  }) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final user = GetIt.I.get<TodoModel>();
  final store = GetIt.I.get<TodoStore>();

  final titleController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    store.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Adicionar Tarefa"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              onChanged: (String? value) => user.title = value,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: "Dê um título à sua anotação...",
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: messageController,
              onChanged: (String? value) => user.message = value,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: "Digite a sua anotação...",
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await store.addTodo(user).then(
                      (value) => Navigator.pushNamed(context, "home"),
                    );
              },
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
