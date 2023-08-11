import 'package:dartz/dartz.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/features/todo/domain/value_object/task_param.dart';

abstract class TaskRepository {
  Either<Failure, List<TaskEntity>> getAllTasks();
  Future<Either<Failure, List<TaskEntity>>> addNewTask(TaskParam taskParam);
  Future<Either<Failure, List<TaskEntity>>> updateTask(
      TaskParam param, int index);
  Future<Either<Failure, List<TaskEntity>>> deleteTask(int index);
}
