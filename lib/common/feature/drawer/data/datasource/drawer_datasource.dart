import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_test/common/core/data/data_base/db_provider.dart';
import 'package:todo_test/common/core/data/model/user_dto.dart';
import 'package:todo_test/utils/constants.dart';

abstract interface class DrawerDatasource {
  UserDTO getUserData();
  int getTheme();
  Future<int> setTheme(int themeMode);
}

base class DrawerDatasourceImpl implements DrawerDatasource {
  final DBProvider dbProvider;
  final SharedPreferences prefs;

  DrawerDatasourceImpl(this.dbProvider, this.prefs);

  @override
  UserDTO getUserData() {
    try {
      return UserDTO.fromDB(dbProvider.get(Constants.user));
    } on HiveError catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  int getTheme() {
    try {
      int? themeMode = prefs.getInt(Constants.theme);
      if (themeMode != null) {
        return themeMode;
      } else {
        // ThemeMode.system.
        return 2;
      }
    } on HiveError catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<int> setTheme(int themeMode) async {
    try {
      await prefs.setInt(Constants.theme, themeMode);
      return getTheme();
    } on HiveError catch (e) {
      print(e);
      throw Exception();
    }
  }
}
