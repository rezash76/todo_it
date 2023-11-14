import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/common/transaction/transaction.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';
import 'package:todo_it/features/todo/domain/repository/task_repository.dart';

base class GetCatTasksTransaction
    implements Transaction<List<TaskEntity>, TaskCategory> {
  final TaskRepository repository;

  GetCatTasksTransaction(this.repository);

  @override
  Future<Either<CacheException, List<TaskEntity>>> call(
          TaskCategory category) async =>
      await repository.getCatTasks(category);
}
