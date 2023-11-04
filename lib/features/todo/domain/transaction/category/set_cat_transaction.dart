import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/transaction/transaction.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';

base class SetCatTransaction
    implements Transaction<TaskCategory, TaskCategory> {
  final TaskRepository repository;

  SetCatTransaction(this.repository);

  @override
  Future<Either<CacheException, TaskCategory>> call(
          TaskCategory category) async =>
      await repository.setCat(category);
}
