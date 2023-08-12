import 'package:dartz/dartz.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/features/todo/data/datasource/local_datasource/task_local_datasource.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';
import 'package:todo_test/features/todo/domain/value_object/updat_task_request.dart';

base class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDatasource localDatasource;

  TaskRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    try {
      var tasks = localDatasource.getAllTasks();
      return Right(tasks);
    } on Exception {
      return Left(Failure(message: 'There is no task'));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> addNewTask(
      TaskRequest taskParam) async {
    try {
      var tasks = await localDatasource.addNewTask(taskParam);
      return Right(tasks);
    } on Exception {
      return Left(Failure(message: 'Somthing went wrong...'));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> updateTask(
      UpdateTaskRequest request) async {
    try {
      var tasks =
          await localDatasource.updateTask(request.taskParam, request.index);
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
