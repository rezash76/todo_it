import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/value_object/no_request.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/transaction/get_all_tasks_transaction.dart';

import 'mock_task_repository.mocks.dart';

void main() {
  late GetAllTasksTransaction getAllTasksTransaction;
  late MockTaskRepository mockTaskRepository;
  late List<TaskEntity> tasks;
  // exception
  late NotFound notFound;
  late TypeMissmatch typeMissmatch;
  late HiveException hiveException;

  group('get all tasks', () {
    setUp(() {
      mockTaskRepository = MockTaskRepository();
      getAllTasksTransaction = GetAllTasksTransaction(mockTaskRepository);
      tasks = [
        TaskEntity(
          id: 'id',
          title: 'title',
          desc: 'desc',
          isCompleted: false,
          createTime: '3421241',
        ),
      ];
      notFound = NotFound();
      typeMissmatch = TypeMissmatch();
      hiveException = HiveException();
    });

    test('should return List<TaskEntity>', () async {
      when(mockTaskRepository.getAllTasks())
          .thenAnswer((_) async => Right(tasks));

      var result = await getAllTasksTransaction.call(NoRequest());
      verify(mockTaskRepository.getAllTasks());
      expect(result, Right(tasks));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return NotFound Exception', () async {
      when(mockTaskRepository.getAllTasks())
          .thenAnswer((_) async => Left(notFound));

      var result = await getAllTasksTransaction.call(NoRequest());
      verify(mockTaskRepository.getAllTasks());
      expect(result, Left(notFound));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return TypeMissmatch Exception', () async {
      when(mockTaskRepository.getAllTasks())
          .thenAnswer((_) async => Left(typeMissmatch));

      var result = await getAllTasksTransaction.call(NoRequest());
      verify(mockTaskRepository.getAllTasks());
      expect(result, Left(typeMissmatch));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return HiveException', () async {
      when(mockTaskRepository.getAllTasks())
          .thenAnswer((_) async => Left(hiveException));

      var result = await getAllTasksTransaction.call(NoRequest());
      verify(mockTaskRepository.getAllTasks());
      expect(result, Left(hiveException));
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
