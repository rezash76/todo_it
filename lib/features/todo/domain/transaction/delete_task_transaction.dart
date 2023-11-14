import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/common/transaction/transaction.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';
import 'package:todo_it/features/todo/domain/repository/task_repository.dart';

base class DeleteTaskTransaction
    implements Transaction<List<TaskEntity>, String> {
  final TaskRepository repository;

  DeleteTaskTransaction(this.repository);

  @override
  Future<Either<CacheException, List<TaskEntity>>> call(String request) async =>
      await repository.deleteTask(request);
}
