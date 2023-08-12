import 'package:dartz/dartz.dart';
import 'package:todo_test/common/transaction/transaction.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/common/error/failure.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';

base class DeleteTaskTransaction implements Transaction<List<TaskEntity>, int> {
  final TaskRepository repository;

  DeleteTaskTransaction(this.repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(int request) =>
      repository.deleteTask(request);
}
