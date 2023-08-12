import 'package:dartz/dartz.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';
import 'package:todo_test/features/todo/domain/value_object/updat_task_request.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getAllTasks();
  Future<Either<Failure, List<TaskEntity>>> addNewTask(TaskRequest taskParam);
  Future<Either<Failure, List<TaskEntity>>> updateTask(
      UpdateTaskRequest request);
  Future<Either<Failure, List<TaskEntity>>> deleteTask(int index);
}
