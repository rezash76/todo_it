import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_it/common/constants.dart';
import 'package:todo_it/common/error/cache.dart';

abstract interface class DrawerDatasource {
  int getTheme();
  Future<int> setTheme(int themeMode);
}

base class DrawerDatasourceImpl implements DrawerDatasource {
  final SharedPreferences prefs;

  DrawerDatasourceImpl(this.prefs);

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
    } on Exception {
      throw TypeMissmatch();
    }
  }

  @override
  Future<int> setTheme(int themeMode) async {
    try {
      await prefs.setInt(Constants.theme, themeMode);
      return getTheme();
    } on Exception {
      throw NullValue();
    }
  }
}
