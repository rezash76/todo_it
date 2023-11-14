import 'package:dartz/dartz.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/common/transaction/transaction.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';
import 'package:todo_it/features/todo/domain/repository/task_repository.dart';
import 'package:todo_it/features/todo/domain/value_object/task_request.dart';

base class UpdateTaskTransaction
    implements Transaction<List<TaskEntity>, TaskRequest> {
  final TaskRepository repository;

  UpdateTaskTransaction(this.repository);

  @override
  Future<Either<CacheException, List<TaskEntity>>> call(
      TaskRequest request) async {
    final task = TaskEntity(
      id: request.id,
      title: request.title,
      desc: request.desc,
      isCompleted: request.isCompleted,
      createTime: request.createTime,
      category: request.category,
    );

    return await repository.updateTask(task);
  }
}
