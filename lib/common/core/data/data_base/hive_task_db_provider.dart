import 'package:hive/hive.dart';
import 'package:todo_test/common/constants.dart';
import 'package:todo_test/common/core/data/data_base/db_provider.dart';
import 'package:todo_test/common/core/data/hive_model/hive_task.dart';

base class HiveTaskDBProvider implements DBProvider<HiveTask> {
  final Box _taskBox = Hive.box(Constants.hiveTask);

  @override
  Future<void> add(Object obj) {
    return _taskBox.add(obj);
  }

  @override
  Future<void> deleteAt(int key) {
    return _taskBox.deleteAt(key);
  }

  @override
  Future<void> put(String key, Object obj) {
    return _taskBox.put(key, obj);
  }

  @override
  Map<dynamic, dynamic> getAll() {
    return _taskBox.toMap();
  }

  @override
  bool isNotEmpty() {
    return _taskBox.isNotEmpty;
  }

  @override
  HiveTask? get(String key) {
    return _taskBox.get(key);
  }

  @override
  Future<void> putAt(int index, Object obj) async {
    return await _taskBox.putAt(index, obj);
  }

  @override
  Future<void> delete(key) {
    return _taskBox.delete(key);
  }
}
