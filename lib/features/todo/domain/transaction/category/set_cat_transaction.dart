import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/common/transaction/transaction.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';
import 'package:todo_it/features/todo/domain/repository/task_repository.dart';

base class SetCatTransaction
    implements Transaction<TaskCategory, TaskCategory> {
  final TaskRepository repository;

  SetCatTransaction(this.repository);

  @override
  Future<Either<CacheException, TaskCategory>> call(
          TaskCategory category) async =>
      await repository.setCat(category);
}
