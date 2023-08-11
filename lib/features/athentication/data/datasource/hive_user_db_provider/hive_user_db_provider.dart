import 'package:hive/hive.dart';
import 'package:todo_test/common/constants.dart';
import 'package:todo_test/common/core/data/data_base/db_provider.dart';
import 'package:todo_test/features/athentication/data/model/hive/hive_user.dart';

base class HiveUserDBProvider implements DBProvider<HiveUser> {
  final Box _userBox = Hive.box(Constants.hiveUser);

  @override
  Future<void> add(Object obj) {
    return _userBox.add(obj);
  }

  @override
  Future<void> delete(dynamic key) {
    return _userBox.delete(key);
  }

  @override
  Map<dynamic, dynamic> getAll() {
    return _userBox.toMap();
  }

  @override
  bool isNotEmpty() {
    return _userBox.isNotEmpty;
  }

  @override
  HiveUser? get(String key) {
    return _userBox.get(key);
  }

  @override
  Future<void> put(key, value) {
    return _userBox.put(key, value);
  }

  @override
  Future<void> deleteAt(int key) {
    return _userBox.deleteAt(key);
  }

  @override
  Future<void> putAt(int index, Object obj) {
    return _userBox.putAt(index, obj);
  }
}
