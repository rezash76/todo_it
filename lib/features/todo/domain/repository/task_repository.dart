import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';

abstract class TaskRepository {
  Future<Either<CacheException, List<TaskEntity>>> getAllTasks();
  Future<Either<CacheException, List<TaskEntity>>> getCatTasks(
      TaskCategory category);
  Future<Either<CacheException, List<TaskEntity>>> addNewTask(
      TaskEntity taskEntity);
  Future<Either<CacheException, List<TaskEntity>>> updateTask(
      TaskEntity taskEntity);
  Future<Either<CacheException, List<TaskEntity>>> deleteTask(String id);
  Future<Either<CacheException, TaskCategory>> getCat();
  Future<Either<CacheException, TaskCategory>> setCat(TaskCategory category);
}
