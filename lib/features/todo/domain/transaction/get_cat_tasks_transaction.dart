import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/transaction/transaction.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';

base class GetCatTasksTransaction
    implements Transaction<List<TaskEntity>, TaskCategory> {
  final TaskRepository repository;

  GetCatTasksTransaction(this.repository);

  @override
  Future<Either<CacheException, List<TaskEntity>>> call(
          TaskCategory category) async =>
      await repository.getCatTasks(category);
}
