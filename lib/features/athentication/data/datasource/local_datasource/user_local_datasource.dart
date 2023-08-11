import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_test/common/constants.dart';
import 'package:todo_test/common/core/data/data_base/db_provider.dart';
import 'package:todo_test/features/athentication/data/model/hive/hive_user.dart';
import 'package:todo_test/features/athentication/data/model/user_dto.dart';

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
        throw Exception();
      }
    } on HiveError catch (e) {
      print(e.message);
      throw Exception();
    }
  }

  @override
  UserDTO getUser() {
    try {
      return UserDTO.fromDB(dbProvider.get(Constants.user));
    } on HiveError catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<void> addUser(HiveUser param) async {
    try {
      return await dbProvider.put(Constants.user, param);
    } on HiveError catch (e) {
      print(e);
      throw Exception();
    }
  }
}
