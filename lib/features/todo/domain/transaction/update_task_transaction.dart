import 'package:dartz/dartz.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';
import 'package:todo_test/features/todo/domain/value_object/task_param.dart';

base class UpdateTaskTransaction {
  final TaskRepository repository;

  UpdateTaskTransaction(this.repository);

  Future<Either<Failure, List<TaskEntity>>> call(TaskParam param, int index) =>
      repository.updateTask(param, index);
}
