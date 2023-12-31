import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_it/common/core/data/data_base/db_provider.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/features/todo/data/model/hive/hive_task.dart';
import 'package:todo_it/features/todo/data/model/task_dto.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';

abstract class TaskLocalDatasource {
  List<TaskDTO> getAllTasks();
  Future<List<TaskDTO>> addNewTask(TaskEntity task);
  Future<List<TaskDTO>> updateTask(TaskEntity task);
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
        task.category.name,
        task.createTime,
        task.isCompleted,
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
  Future<List<TaskDTO>> updateTask(TaskEntity task) async {
    try {
      HiveTask hiveTask = HiveTask(
        task.id,
        task.title,
        task.desc,
        task.category.name,
        task.createTime,
        task.isCompleted,
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
