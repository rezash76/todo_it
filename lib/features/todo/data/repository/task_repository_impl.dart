import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/data/datasource/local_datasource/task_local_datasource.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';

base class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDatasource localDatasource;

  TaskRepositoryImpl(this.localDatasource);

  @override
  Future<Either<CacheException, List<TaskEntity>>> getAllTasks() async {
    try {
      var tasks = localDatasource.getAllTasks();
      return Right(tasks);
    } on NotFound {
      return Left(NotFound());
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }

  @override
  Future<Either<CacheException, List<TaskEntity>>> addNewTask(
      TaskRequest taskParam) async {
    try {
      var tasks = await localDatasource.addNewTask(taskParam);
      return Right(tasks);
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }

  @override
  Future<Either<CacheException, List<TaskEntity>>> updateTask(
      TaskRequest request) async {
    try {
      var tasks = await localDatasource.updateTask(request);
      return Right(tasks);
    } on NotFound {
      return Left(NotFound());
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }

  @override
  Future<Either<CacheException, List<TaskEntity>>> deleteTask(String id) async {
    try {
      var tasks = await localDatasource.deleteTask(id);
      return Right(tasks);
    } on NotFound {
      return Left(NotFound());
    } on TypeMissmatch {
      return Left(TypeMissmatch());
    } on HiveException catch (error) {
      return Left(HiveException(message: error.message));
    }
  }
}
