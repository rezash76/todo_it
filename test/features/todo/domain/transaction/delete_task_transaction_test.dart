import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/transaction/delete_task_transaction.dart';

import 'add_new_task_transaction_test.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late DeleteTaskTransaction deleteTaskTransaction;
  late List<TaskEntity> tasks;
  // exception
  late TypeMissmatch typeMissmatch;
  late HiveException hiveException;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    deleteTaskTransaction = DeleteTaskTransaction(mockTaskRepository);
    tasks = [
      TaskEntity('as3d', 'asef', false),
      TaskEntity('aewsd', 'asef', true),
      TaskEntity('asesfd', 'asef', true),
      TaskEntity('asgd', 'asef', false),
    ];
    typeMissmatch = TypeMissmatch();
    hiveException = HiveException();
  });

  group('Delete tasks', () {
    test('should return List<TaskEntity>', () async {
      when(mockTaskRepository.deleteTask(any))
          .thenAnswer((_) async => Right(tasks));

      var result = await deleteTaskTransaction.call(2);
      verify(mockTaskRepository.deleteTask(2));
      expect(result, Right(tasks));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return TypeMissmatch Exception.', () async {
      when(mockTaskRepository.deleteTask(any))
          .thenAnswer((_) async => Left(typeMissmatch));

      var result = await deleteTaskTransaction.call(2);
      verify(mockTaskRepository.deleteTask(2));
      expect(result, Left(typeMissmatch));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return HiveException.', () async {
      when(mockTaskRepository.deleteTask(any))
          .thenAnswer((_) async => Left(hiveException));

      var result = await deleteTaskTransaction.call(2);
      verify(mockTaskRepository.deleteTask(2));
      expect(result, Left(hiveException));
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
