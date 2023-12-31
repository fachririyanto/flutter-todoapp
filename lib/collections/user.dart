import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class User {
  Id id = Isar.autoIncrement;

  String? name;

  String? password;

  User({
    this.name,
    this.password,
  });
}
