import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_it/common/constants.dart';
import 'package:todo_it/common/core/data/data_base/db_provider.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/features/athentication/data/model/hive/hive_user.dart';
import 'package:todo_it/features/athentication/data/model/user_dto.dart';

abstract class UserLocalDatasource {
  UserDTO isUserExist();
  UserDTO getUser();
  Future<void> addUser(HiveUser param);
}

class UserLocalDatasourceImple implements UserLocalDatasource {
  final DBProvider dbProvider;

  UserLocalDatasourceImple(this.dbProvider);

  @override
  UserDTO isUserExist() {
    try {
      final isNotEmpty = dbProvider.isNotEmpty();
      if (isNotEmpty) {
        var raw = dbProvider.getAll();
        var user = UserDTO.fromDB(raw.values.first);
        return user;
      } else {
        throw NotFound();
      }
    } on HiveError catch (error) {
      throw HiveException(message: error.message);
    }
  }

  @override
  UserDTO getUser() {
    try {
      return UserDTO.fromDB(dbProvider.get(Constants.user));
    } on Exception {
      throw TypeMissmatch();
    } on HiveError catch (error) {
      throw HiveException(message: error.message);
    }
  }

  @override
  Future<void> addUser(HiveUser param) async {
    try {
      return await dbProvider.put(Constants.user, param);
    } on HiveError catch (error) {
      throw HiveException(message: error.message);
    }
  }
}
