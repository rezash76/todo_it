import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/common/value_object/no_request.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/transaction/get_all_tasks_transaction.dart';

import 'add_new_task_transaction_test.mocks.dart';

void main() {
  late GetAllTasksTransaction getAllTasksTransaction;
  late MockTaskRepository mockTaskRepository;
  List<TaskEntity> tasks = [
    TaskEntity('asd', 'asaweef', false),
    TaskEntity('asf', 'asfeaef', true),
    TaskEntity('fweew', 'asfef', false),
  ];

  group('get all tasks', () {
    setUp(() {
      mockTaskRepository = MockTaskRepository();
      getAllTasksTransaction = GetAllTasksTransaction(mockTaskRepository);
    });

    test('should return List<TaskEntity>', () async {
      when(mockTaskRepository.getAllTasks())
          .thenAnswer((_) async => Right(tasks));

      var result = await getAllTasksTransaction.call(NoRequest());
      verify(mockTaskRepository.getAllTasks());
      expect(result, Right(tasks));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    // test('should return CacheException', () async {
    //   when(mockTaskRepository.getAllTasks())
    //       .thenAnswer((realInvocation) async => Left(CacheException()));

    //   var result = await getAllTasksTransaction.call(NoRequest());
    //   verify(mockTaskRepository.getAllTasks());
    //   expect(result, Left(CacheException()));
    //   verifyNoMoreInteractions(mockTaskRepository);
    // });
  });
}
