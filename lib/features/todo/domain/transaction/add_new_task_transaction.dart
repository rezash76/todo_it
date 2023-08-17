import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/transaction/transaction.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';

base class AddNewTaskTransaction
    implements Transaction<List<TaskEntity>, TaskRequest> {
  final TaskRepository repository;

  AddNewTaskTransaction(this.repository);

  @override
  Future<Either<CacheException, List<TaskEntity>>> call(
          TaskRequest request) async =>
      await repository.addNewTask(request);
}
