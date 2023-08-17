import 'package:todo_test/common/entity/entity.dart';
import 'package:uuid/uuid.dart';

base class UserEntity extends Entity {
  final String name;
  final String family;
  final String username;
  final String password;
  bool isLogin;

  UserEntity(
    this.name,
    this.family,
    this.username,
    this.password,
    this.isLogin,
  ) : super(const Uuid().v1());
}
