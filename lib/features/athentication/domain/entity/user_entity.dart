import 'package:todo_it/common/entity/entity.dart';

base class UserEntity extends Entity {
  final String name;
  final String family;
  final String username;
  final String password;
  bool isLogin;

  UserEntity({
    required String id,
    required this.name,
    required this.family,
    required this.username,
    required this.password,
    required this.isLogin,
  }) : super(id: id);
}
