import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/transaction/update_task_transaction.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';
import 'package:todo_test/features/todo/domain/value_object/updat_task_request.dart';

import 'add_new_task_transaction_test.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late UpdateTaskTransaction updateTaskTransaction;
  late List<TaskEntity> tasks;
  late TaskRequest taskReq;
  late UpdateTaskRequest request;
  // exception
  late NotFound notFound;
  late TypeMissmatch typeMissmatch;
  late HiveException hiveException;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    updateTaskTransaction = UpdateTaskTransaction(mockTaskRepository);
    tasks = [
      TaskEntity('asq3d', 'asef', false),
      TaskEntity('aedwsd', 'asef', true),
      TaskEntity('aseesfd', 'asef', true),
      TaskEntity('asegd', 'asef', false),
    ];
    taskReq = TaskRequest('title', 'desc', true);
    request = UpdateTaskRequest(taskReq, 4);
    notFound = NotFound();
    typeMissmatch = TypeMissmatch();
    hiveException = HiveException();
  });

  group('Update tasks', () {
    test('should return List<TaskEntity>', () async {
      when(mockTaskRepository.updateTask(any))
          .thenAnswer((_) async => Right(tasks));

      var result = await updateTaskTransaction.call(request);
      verify(mockTaskRepository.updateTask(request));
      expect(result, Right(tasks));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return NotFound Exception', () async {
      when(mockTaskRepository.updateTask(any))
          .thenAnswer((_) async => Left(notFound));

      var result = await updateTaskTransaction.call(request);
      verify(mockTaskRepository.updateTask(request));
      expect(result, Left(notFound));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return TypeMissmatch Exception', () async {
      when(mockTaskRepository.updateTask(any))
          .thenAnswer((_) async => Left(typeMissmatch));

      var result = await updateTaskTransaction.call(request);
      verify(mockTaskRepository.updateTask(request));
      expect(result, Left(typeMissmatch));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return HiveException', () async {
      when(mockTaskRepository.updateTask(any))
          .thenAnswer((_) async => Left(hiveException));

      var result = await updateTaskTransaction.call(request);
      verify(mockTaskRepository.updateTask(request));
      expect(result, Left(hiveException));
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
