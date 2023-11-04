import 'package:dartz/dartz.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/transaction/transaction.dart';
import 'package:todo_test/common/value_object/no_request.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';

base class GetCatTransaction implements Transaction<TaskCategory, NoRequest> {
  final TaskRepository repository;

  GetCatTransaction(this.repository);

  @override
  Future<Either<CacheException, TaskCategory>> call(NoRequest request) async =>
      await repository.getCat();
}
