import 'package:dartz/dartz.dart';
import 'package:todo_test/common/core/domain/entities/task_entity.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/features/todo/data/datasource/task_local_datasource.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';
import 'package:todo_test/features/todo/domain/value_object/task_param.dart';

base class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDatasource localDatasource;

  TaskRepositoryImpl(this.localDatasource);

  @override
  Either<Failure, List<TaskEntity>> getAllTasks() {
    try {
      var tasks = localDatasource.getAllTasks();
      return Right(tasks);
    } on Exception {
      return Left(Failure(message: 'There is no task'));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> addNewTask(
      TaskParam taskParam) async {
    try {
      var tasks = await localDatasource.addNewTask(taskParam);
      return Right(tasks);
    } on Exception {
      return Left(Failure(message: 'Somthing went wrong...'));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> updateTask(
      TaskParam param, int index) async {
    try {
      var tasks = await localDatasource.updateTask(param, index);
      return Right(tasks);
    } on Exception {
      return Left(Failure(message: 'Somthing went wrong...'));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> deleteTask(int index) async {
    try {
      var tasks = await localDatasource.deleteTask(index);
      return Right(tasks);
    } on Exception {
      return Left(Failure(message: 'Somthing went wrong...'));
    }
  }
}
