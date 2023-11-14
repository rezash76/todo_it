import 'package:todo_it/features/athentication/data/model/hive/hive_user.dart';
import 'package:todo_it/features/athentication/domain/entity/user_entity.dart';

base class UserDTO extends UserEntity {
  UserDTO({
    required super.id,
    required super.name,
    required super.family,
    required super.username,
    required super.password,
    required super.isLogin,
  });

  factory UserDTO.fromDB(HiveUser hiveUser) {
    return UserDTO(
      id: hiveUser.id,
      name: hiveUser.name,
      family: hiveUser.family,
      username: hiveUser.username,
      password: hiveUser.password,
      isLogin: hiveUser.isLogin,
    );
  }

  HiveUser toDB(UserDTO user) {
    return HiveUser(
      user.id,
      user.name,
      user.family,
      user.username,
      user.password,
      user.isLogin,
    );
  }
}
