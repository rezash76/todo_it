import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/transaction/transaction.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';
import 'package:todo_test/features/todo/domain/value_object/updat_task_request.dart';

base class UpdateTaskTransaction
    implements Transaction<List<TaskEntity>, UpdateTaskRequest> {
  final TaskRepository repository;

  UpdateTaskTransaction(this.repository);

  @override
  Future<Either<CacheException, List<TaskEntity>>> call(UpdateTaskRequest request) =>
      repository.updateTask(request);
}
