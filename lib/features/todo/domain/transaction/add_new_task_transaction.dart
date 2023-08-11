import 'package:dartz/dartz.dart';
import 'package:todo_test/common/core/domain/entities/task_entity.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';

base class AddNewTaskTransaction {
  final TaskRepository repository;

  AddNewTaskTransaction(this.repository);

  Future<Either<Failure, List<TaskEntity>>> call(task) =>
      repository.addNewTask(task);
}
