import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../collections/todo.dart';
import '../collections/user.dart';

class IsarServices {
  late final Future<Isar> db;

  // constructor
  IsarServices() {
    db = open();
  }

  // open database
  Future<Isar> open() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [UserSchema, TodoSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
