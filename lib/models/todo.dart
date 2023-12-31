import 'package:isar/isar.dart';
import '../utils/isar_services.dart';
import '../collections/todo.dart';

class TodoModel extends IsarServices {
  // get all todos
  Future<List<Todo>> getAllTodos() async {
    final isar = await db;
    return await isar.todos.where().findAll();
  }

  // stream all todos
  Stream<List<Todo>> streamAllTodos() async* {
    final isar = await db;
    yield* isar.todos.where().watch(fireImmediately: true);
  }

  // get todo by id
  Future<Todo?> getTodo(Id id) async {
    final isar = await db;
    return await isar.todos.get(id);
  }

  // add new todo
  Future<void> addNewTodo(Todo todo) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }

  // update todo
  Future<void> updateTodo(
    Id id,
    String title,
    bool isCompleted,
  ) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final todo = await isar.todos.get(id);

      if (todo == null) {
        throw Exception('Todo not found!');
      }

      todo.title = title;
      todo.isCompleted = isCompleted;
      todo.updatedAt = DateTime.now();

      await isar.todos.put(todo);
    });
  }

  // delete todo
  Future<void> deleteTodo(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.todos.delete(id);
    });
  }
}
