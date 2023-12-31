import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';
import 'package:todo_it/features/todo/domain/repository/task_repository.dart';
import 'package:todo_it/features/todo/domain/transaction/update_task_transaction.dart';
import 'package:todo_it/features/todo/domain/value_object/task_request.dart';

import 'mock_task_repository.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late UpdateTaskTransaction updateTaskTransaction;
  late List<TaskEntity> tasks;
  late TaskRequest taskReq;
  late TaskEntity task;
  // exception
  late NotFound notFound;
  late TypeMissmatch typeMissmatch;
  late HiveException hiveException;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    updateTaskTransaction = UpdateTaskTransaction(mockTaskRepository);
    tasks = [
      TaskEntity(
        id: 'id',
        title: 'title',
        desc: 'desc',
        isCompleted: false,
        createTime: '3421241',
        category: TaskCategory.personal,
      ),
    ];
    taskReq = TaskRequest(
      id: 'id',
      title: 'Hi',
      desc: 'desc',
      isCompleted: false,
      createTime: '239483',
      category: TaskCategory.personal,
    );
    task = TaskEntity(
      id: 'id',
      title: 'title',
      desc: 'desc',
      isCompleted: true,
      createTime: '123443',
      category: TaskCategory.personal,
    );
    notFound = NotFound();
    typeMissmatch = TypeMissmatch();
    hiveException = HiveException();
  });

  group('Update tasks', () {
    test('should return List<TaskEntity>', () async {
      when(mockTaskRepository.updateTask(any))
          .thenAnswer((_) async => Right(tasks));

      var result = await updateTaskTransaction.call(taskReq);
      verify(mockTaskRepository.updateTask(task));
      expect(result, Right(tasks));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return NotFound Exception', () async {
      when(mockTaskRepository.updateTask(any))
          .thenAnswer((_) async => Left(notFound));

      var result = await updateTaskTransaction.call(taskReq);
      verify(mockTaskRepository.updateTask(task));
      expect(result, Left(notFound));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return TypeMissmatch Exception', () async {
      when(mockTaskRepository.updateTask(any))
          .thenAnswer((_) async => Left(typeMissmatch));

      var result = await updateTaskTransaction.call(taskReq);
      verify(mockTaskRepository.updateTask(task));
      expect(result, Left(typeMissmatch));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return HiveException', () async {
      when(mockTaskRepository.updateTask(any))
          .thenAnswer((_) async => Left(hiveException));

      var result = await updateTaskTransaction.call(taskReq);
      verify(mockTaskRepository.updateTask(task));
      expect(result, Left(hiveException));
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
