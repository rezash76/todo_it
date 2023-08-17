import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/common/error/cache.dart';
import 'package:todo_test/features/todo/data/datasource/local_datasource/task_local_datasource.dart';
import 'package:todo_test/features/todo/data/repository/task_repository_impl.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/repository/task_repository.dart';
import 'package:todo_test/features/todo/domain/transaction/add_new_task_transaction.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';
import 'package:todo_test/features/todo/presentation/bloc/task_bloc.dart';

import 'add_new_task_transaction_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  late AddNewTaskTransaction addNewTaskTransaction;
  late MockTaskRepository mockTaskRepository;
  List<TaskEntity> tasks = [
    TaskEntity('asd', 'asef', false),
  ];

  var request = TaskRequest('Hi', 'desc', false);

  group('add new task transaction', () {
    setUp(() {
      mockTaskRepository = MockTaskRepository();
      addNewTaskTransaction = AddNewTaskTransaction(mockTaskRepository);
    });

    test('should return List<TaskEntity>', () async {
      when(mockTaskRepository.addNewTask(any))
          .thenAnswer((_) async => Right(tasks));

      var result = await addNewTaskTransaction.call(request);
      verify(mockTaskRepository.addNewTask(request));
      expect(result, Right(tasks));
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
