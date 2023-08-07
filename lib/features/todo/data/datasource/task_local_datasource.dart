import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_test/common/core/data/data_base/db_provider.dart';
import 'package:todo_test/common/core/data/hive_model/hive_task.dart';
import 'package:todo_test/common/core/data/model/task_dto.dart';
import 'package:todo_test/features/todo/domain/value_object/task_param.dart';

abstract class TaskLocalDatasource {
  List<TaskDTO> getAllTasks();
  Future<List<TaskDTO>> addNewTask(TaskParam task);
  Future<List<TaskDTO>> updateTask(TaskParam task, int index);
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
        throw Exception();
      }
    } on HiveError catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<List<TaskDTO>> addNewTask(TaskParam task) async {
    try {
      HiveTask hiveTask = HiveTask(task.title, task.desc, task.isCompleted);
      await dbProvider.add(hiveTask);
      return getAllTasks();
    } on HiveError catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<List<TaskDTO>> updateTask(TaskParam task, int index) async {
    try {
      HiveTask hiveTask = HiveTask(
        task.title,
        task.desc,
        task.isCompleted,
      );
      await dbProvider.putAt(index, hiveTask);
      return getAllTasks();
    } on HiveError catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<List<TaskDTO>> deleteTask(int index) async {
    try {
      await dbProvider.deleteAt(index);
      return getAllTasks();
    } on HiveError catch (e) {
      print(e);
      throw Exception();
    }
  }
}
