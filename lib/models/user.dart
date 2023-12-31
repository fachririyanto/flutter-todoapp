import 'package:isar/isar.dart';
import '../utils/isar_services.dart';
import '../collections/user.dart';

class UserModel extends IsarServices {
  // check if user is already signed up
  Future<bool> isUserExists() async {
    final isar = await db;
    final user = await isar.users.filter().nameIsNotEmpty().findFirst();
    return user != null;
  }

  // get current user
  Future<User?> getCurrentUser() async {
    final isar = await db;
    final user = await isar.users.filter().nameIsNotEmpty().findFirst();
    return user;
  }

  // register new user
  Future<void> createUser(User user) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  // update user
  Future<void> updateUser(Id id, String name, String password) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final currentUser = await isar.users.get(id);

      if (currentUser == null) {
        throw Exception('User not found!');
      }

      currentUser.name = name;
      currentUser.password = password;

      await isar.users.put(currentUser);
    });
  }

  // login
  Future<User?> signin(String name, String password) async {
    final isar = await db;
    final user = await isar.users
        .where()
        .filter()
        .nameEqualTo(name)
        .passwordEqualTo(password)
        .findFirst();
    return user;
  }
}
