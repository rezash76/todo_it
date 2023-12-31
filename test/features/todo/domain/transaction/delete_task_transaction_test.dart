import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';
import 'package:todo_it/features/todo/domain/transaction/delete_task_transaction.dart';

import 'mock_task_repository.mocks.dart';

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
      TaskEntity(
        id: 'id',
        title: 'title',
        desc: 'desc',
        isCompleted: false,
        createTime: '3421241',
        category: TaskCategory.personal,
      ),
    ];
    typeMissmatch = TypeMissmatch();
    hiveException = HiveException();
  });

  group('Delete tasks', () {
    test('should return List<TaskEntity>', () async {
      when(mockTaskRepository.deleteTask(any))
          .thenAnswer((_) async => Right(tasks));

      var result = await deleteTaskTransaction.call('id');
      verify(mockTaskRepository.deleteTask('id'));
      expect(result, Right(tasks));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return TypeMissmatch Exception.', () async {
      when(mockTaskRepository.deleteTask(any))
          .thenAnswer((_) async => Left(typeMissmatch));

      var result = await deleteTaskTransaction.call('id');
      verify(mockTaskRepository.deleteTask('id'));
      expect(result, Left(typeMissmatch));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return HiveException.', () async {
      when(mockTaskRepository.deleteTask(any))
          .thenAnswer((_) async => Left(hiveException));

      var result = await deleteTaskTransaction.call('id');
      verify(mockTaskRepository.deleteTask('id'));
      expect(result, Left(hiveException));
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
