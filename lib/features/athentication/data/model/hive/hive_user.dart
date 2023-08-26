import 'package:hive/hive.dart';

part 'hive_user.g.dart';

@HiveType(typeId: 0)
base class HiveUser extends HiveObject {
  HiveUser(
    this.id,
    this.name,
    this.family,
    this.username,
    this.password,
    this.isLogin,
  );

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String family;

  @HiveField(3)
  String username;

  @HiveField(4)
  String password;

  @HiveField(5)
  bool isLogin;
}
