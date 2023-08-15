import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_test/common/core/data/data_base/db_provider.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/features/todo/data/model/hive/hive_task.dart';
import 'package:todo_test/features/todo/data/model/task_dto.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';

abstract class TaskLocalDatasource {
  List<TaskDTO> getAllTasks();
  Future<List<TaskDTO>> addNewTask(TaskRequest task);
  Future<List<TaskDTO>> updateTask(TaskRequest task, int index);
  Future<List<TaskDTO>> deleteTask(int index);
}

base class TaskLocalDatasourceImpl extends TaskLocalDatasource {
  final DBProvider dbProvider;

  TaskLocalDatasourceImpl(this.dbProvider);

  @override
  List<TaskDTO> getAllTasks() {
    try {
      var allTasksMap = dbProvider.getAll();

      if (allTasksMap.isNotEmpty) {
        List values = allTasksMap.values.toList();
        List<TaskDTO> tasks = [];
        for (var e in values) {
          tasks.add(TaskDTO.fromDB(e));
        }
        var reversedTasks = tasks.reversed.toList();
        return reversedTasks;
      } else {
        throw NotFound();
      }
    } on TypeMissmatch {
      throw TypeMissmatch();
    } on HiveError catch (error) {
      throw HiveException(message: error.message);
    }
  }

  @override
  Future<List<TaskDTO>> addNewTask(TaskRequest task) async {
    try {
      HiveTask hiveTask = HiveTask(task.title, task.desc, task.isCompleted);
      await dbProvider.add(hiveTask);
      return getAllTasks();
    } on TypeMissmatch {
      throw TypeMissmatch();
    } on HiveError catch (error) {
      throw HiveException(message: error.message);
    }
  }

  @override
  Future<List<TaskDTO>> updateTask(TaskRequest task, int index) async {
    try {
      HiveTask hiveTask = HiveTask(
        task.title,
        task.desc,
        task.isCompleted,
      );
      await dbProvider.putAt(index, hiveTask);
      return getAllTasks();
    } on TypeMissmatch {
      throw TypeMissmatch();
    } on Exception {
      throw NotFound();
    } on HiveError catch (error) {
      throw HiveException(message: error.message);
    }
  }

  @override
  Future<List<TaskDTO>> deleteTask(int index) async {
    try {
      await dbProvider.deleteAt(index);
      return getAllTasks();
    } on TypeMissmatch {
      throw TypeMissmatch();
    } on HiveError catch (error) {
      throw HiveException(message: error.message);
    }
  }
}
