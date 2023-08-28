import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_test/common/core/data/data_base/db_provider.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/features/todo/data/model/hive/hive_task.dart';
import 'package:todo_test/features/todo/data/model/task_dto.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';

abstract class TaskLocalDatasource {
  List<TaskDTO> getAllTasks();
  Future<List<TaskDTO>> addNewTask(TaskEntity task);
  Future<List<TaskDTO>> updateTask(TaskRequest task);
  Future<List<TaskDTO>> deleteTask(String id);
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
        final tasks = values.map((e) => TaskDTO.fromDB(e)).toList();
        // reversing
        tasks.sort((a, b) => b.createTime.compareTo(a.createTime));
        return tasks;
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
  Future<List<TaskDTO>> addNewTask(TaskEntity task) async {
    try {
      HiveTask hiveTask = HiveTask(
        task.id,
        task.title,
        task.desc,
        task.isCompleted,
        task.createTime,
      );
      await dbProvider.put(hiveTask.id, hiveTask);
      return getAllTasks();
    } on TypeMissmatch {
      throw TypeMissmatch();
    } on HiveError catch (error) {
      throw HiveException(message: error.message);
    }
  }

  @override
  Future<List<TaskDTO>> updateTask(TaskRequest task) async {
    try {
      HiveTask hiveTask = HiveTask(
        task.id,
        task.title,
        task.desc,
        task.isCompleted,
        task.createTime,
      );
      await dbProvider.put(hiveTask.id, hiveTask);
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
  Future<List<TaskDTO>> deleteTask(String id) async {
    try {
      await dbProvider.delete(id);
      return getAllTasks();
    } on NotFound {
      throw NotFound();
    } on TypeMissmatch {
      throw TypeMissmatch();
    } on HiveError catch (error) {
      throw HiveException(message: error.message);
    }
  }
}
