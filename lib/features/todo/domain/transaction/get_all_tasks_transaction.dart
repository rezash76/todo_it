import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/transaction/transaction.dart';
import 'package:todo_test/common/value_object/no_request.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';

base class GetAllTasksTransaction
    implements Transaction<List<TaskEntity>, NoRequest> {
  final TaskRepository repository;

  GetAllTasksTransaction(this.repository);

  @override
  Future<Either<CacheException, List<TaskEntity>>> call(
          NoRequest request) async =>
      await repository.getAllTasks();
}
