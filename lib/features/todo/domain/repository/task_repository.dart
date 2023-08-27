import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';

abstract class TaskRepository {
  Future<Either<CacheException, List<TaskEntity>>> getAllTasks();
  Future<Either<CacheException, List<TaskEntity>>> addNewTask(
      TaskRequest taskParam);
  Future<Either<CacheException, List<TaskEntity>>> updateTask(
      TaskRequest request);
  Future<Either<CacheException, List<TaskEntity>>> deleteTask(String id);
}
