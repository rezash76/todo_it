import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/transaction/add_new_task_transaction.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';

import 'add_new_task_transaction_test.mocks.dart';

void main() {
  late AddNewTaskTransaction addNewTaskTransaction;
  late MockTaskRepository mockTaskRepository;
  late List<TaskEntity> tasks;
  late TaskRequest request;
  // exception
  late TypeMissmatch typeMissmatch;
  late HiveException hiveException;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    addNewTaskTransaction = AddNewTaskTransaction(mockTaskRepository);
    tasks = [TaskEntity('asd', 'asef', false)];
    request = TaskRequest('Hi', 'desc', false);
    typeMissmatch = TypeMissmatch();
    hiveException = HiveException();
  });

  group('add new task transaction', () {
    test('should return List<TaskEntity>', () async {
      when(mockTaskRepository.addNewTask(any))
          .thenAnswer((_) async => Right(tasks));

      var result = await addNewTaskTransaction.call(request);
      verify(mockTaskRepository.addNewTask(request));
      expect(result, Right(tasks));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return TypeMissmatch Exception.', () async {
      when(mockTaskRepository.addNewTask(any))
          .thenAnswer((_) async => Left(typeMissmatch));

      var result = await addNewTaskTransaction.call(request);
      verify(mockTaskRepository.addNewTask(request));
      expect(result, Left(typeMissmatch));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return HiveException.', () async {
      when(mockTaskRepository.addNewTask(any))
          .thenAnswer((_) async => Left(hiveException));

      var result = await addNewTaskTransaction.call(request);
      verify(mockTaskRepository.addNewTask(request));
      expect(result, Left(hiveException));
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
