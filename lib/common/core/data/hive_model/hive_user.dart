import 'package:hive/hive.dart';

part 'hive_user.g.dart';

@HiveType(typeId: 0)
base class HiveUser extends HiveObject {
  HiveUser(this.name, this.family, this.username, this.password, this.isLogin);

  @HiveField(0)
  String name;

  @HiveField(1)
  String family;

  @HiveField(2)
  String username;

  @HiveField(3)
  String password;

  @HiveField(4)
  bool isLogin;
}
