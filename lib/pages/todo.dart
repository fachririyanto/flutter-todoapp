import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../utils/auth.dart';
import '../utils/colors.dart';
import '../collections/todo.dart';
import '../models/todo.dart';
import './parts/dialog_add_todo.dart';
import './parts/dialog_edit_todo.dart';
import './parts/todo_tile.dart';
import './parts/sidebar.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  // dialog state
  final todoNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      UserAuth.isLoggedIn().then((isLoggedIn) {
        if (!isLoggedIn) {
          Navigator.of(context).pushNamed('/auth/signin');
        }
      });
    });
  }

  // save todo
  void onSave() {
    final todoName = todoNameController.text;

    if (todoName.isEmpty) {
      return;
    }

    final Todo newTodo = Todo(
      title: todoName,
      isCompleted: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    TodoModel().addNewTodo(newTodo).then((_) {
      setState(() {
        todoNameController.text = '';
      });

      Navigator.of(context).pop();
    });
  }

  // create a new todo
  void createTodo() {
    showDialog(
      context: context,
      builder: (builder) {
        return DialogAddTodo(
          todoNameController: todoNameController,
          onSave: onSave,
          onCancel: () {
            setState(() {
              todoNameController.text = '';
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  // edit todo
  void editTodo(Id id, String todoName, bool isCompleted) {
    todoNameController.text = todoName;

    showDialog(
      context: context,
      builder: (builder) {
        return DialogEditTodo(
          todoNameController: todoNameController,
          onSave: () {
            final todoName = todoNameController.text;

            if (todoName.isEmpty) {
              return;
            }

            TodoModel().updateTodo(id, todoName, isCompleted).then((_) {
              setState(() {
                todoNameController.text = '';
              });
              Navigator.of(context).pop();
            });
          },
          onCancel: () {
            setState(() {
              todoNameController.text = '';
            });
            Navigator.of(context).pop();
          },
          id: id,
          todoName: todoName,
          isCompleted: isCompleted,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
        title: const Text(
          'Todo List',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
      drawer: const Sidebar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            StreamBuilder<List<Todo>>(
              stream: TodoModel().streamAllTodos(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final todos = snapshot.data!;

                if (todos.isEmpty) {
                  return const SizedBox(
                    child: Text(
                      'No todos found!',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  );
                }

                return Column(
                  children: todos.map((todo) {
                    return TodoTile(
                      key: Key(todo.id.toString()),
                      taskName: todo.title!,
                      taskCompleted: todo.isCompleted!,
                      toggleTaskCompleted: (value) {
                        TodoModel().updateTodo(
                          todo.id,
                          todo.title!,
                          value,
                        );
                      },
                      deleteTask: (context) {
                        TodoModel().deleteTodo(
                          todo.id,
                        );
                      },
                      editTask: (context) {
                        editTodo(
                          todo.id,
                          todo.title!,
                          todo.isCompleted!,
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTodo,
        backgroundColor: AppColors.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
