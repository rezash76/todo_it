import 'package:todo_test/features/athentication/data/model/hive/hive_user.dart';
import 'package:todo_test/features/athentication/domain/entity/user_entity.dart';

base class UserDTO extends UserEntity {
  UserDTO(
    super.name,
    super.family,
    super.username,
    super.password,
    super.isLogin,
  );

  factory UserDTO.fromDB(HiveUser hiveUser) {
    return UserDTO(
      hiveUser.name,
      hiveUser.family,
      hiveUser.username,
      hiveUser.password,
      hiveUser.isLogin,
    );
  }

  HiveUser toDB(UserDTO user) {
    return HiveUser(
      user.name,
      user.family,
      user.username,
      user.password,
      user.isLogin,
    );
  }
}
