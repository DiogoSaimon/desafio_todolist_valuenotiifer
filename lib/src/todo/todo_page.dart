import 'package:desafio_todo_list_value_notifier/src/todo/models/todo_model.dart';
import 'package:desafio_todo_list_value_notifier/src/todo/states/todo_state.dart';
import 'package:desafio_todo_list_value_notifier/src/todo/store/todo_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final store = GetIt.I.get<TodoStore>();
  final todo = GetIt.I.get<TodoModel>();

  final titleController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    store.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      store.fetchTodo();
    });
  }

  @override
  void dispose() {
    store.removeListener(() {
      store.fetchTodo();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    final state = store.value;

    _showUpdateTaskDialog(
      String id,
      String title,
      String message,
    ) =>
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Alteração de Tarefa"),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Título',
                        ),
                        controller: titleController,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'Mensagem',
                        ),
                        controller: messageController,
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  child: const Text("Alterar"),
                  onPressed: () {
                    store.updateTodo(
                      id: id,
                      title: titleController.text,
                      message: messageController.text,
                    );
                    Navigator.of(context).pop();
                    titleController.text = "";
                    messageController.text = "";
                  },
                ),
              ],
            );
          },
        );

    if (state is EmptyTodoState) {
      child = const Center(
        child: Text("Lista Vazia"),
      );
    }
    if (state is LoadingTodoState) {
      child = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is ErrorTodoState) {
      child = Center(
        child: Text(state.message),
      );
    }

    if (state is SucessTodoState) {
      child = ListView.builder(
          itemCount: state.todo.length,
          itemBuilder: (_, index) {
            final todo = state.todo[index];
            return Dismissible(
              background: Container(
                color: const Color(0xFFE57373),
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.delete_outlined),
                    Icon(Icons.delete_outlined),
                  ],
                ),
              ),
              key: ValueKey(todo.title),
              confirmDismiss: (direction) {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Apagar Tarefa"),
                        content: const Text("Deseja apagar a tarefa?"),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await store
                                    .deleteTodo(todo)
                                    .then((value) => Navigator.pop(context));
                                setState(() {
                                  store.fetchTodo();
                                });
                              },
                              child: const Text("Sim")),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Não")),
                        ],
                      );
                    });
              },
              child: ListTile(
                onTap: () async {
                  await _showUpdateTaskDialog(
                    todo.id!,
                    todo.title!,
                    todo.message!,
                  );
                },
                title: Text(todo.title!),
                subtitle: Text(todo.message!),
              ),
            );
          });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("TodoList + ValueNotifier"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("add");
        },
        child: const Icon(Icons.note_add_outlined),
      ),
    );
  }
}
