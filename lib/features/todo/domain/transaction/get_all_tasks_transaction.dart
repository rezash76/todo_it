import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/common/transaction/transaction.dart';
import 'package:todo_it/common/value_object/no_request.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';
import 'package:todo_it/features/todo/domain/repository/task_repository.dart';

base class GetAllTasksTransaction
    implements Transaction<List<TaskEntity>, NoRequest> {
  final TaskRepository repository;

  GetAllTasksTransaction(this.repository);

  @override
  Future<Either<CacheException, List<TaskEntity>>> call(
          NoRequest request) async =>
      await repository.getAllTasks();
}
