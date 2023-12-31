import 'package:isar/isar.dart';

part 'todo.g.dart';

@Collection()
class Todo {
  Id id = Isar.autoIncrement;

  String? title;

  bool? isCompleted;

  DateTime? createdAt;

  DateTime? updatedAt;

  Todo({
    this.title,
    this.isCompleted,
    this.createdAt,
    this.updatedAt,
  });
}
