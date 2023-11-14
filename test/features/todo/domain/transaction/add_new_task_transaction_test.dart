import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_it/common/error/cache.dart';
import 'package:todo_it/features/todo/domain/entity/task_entity.dart';
import 'package:todo_it/features/todo/domain/transaction/add_new_task_transaction.dart';
import 'package:todo_it/features/todo/domain/value_object/task_request.dart';

import 'mock_task_repository.mocks.dart';

void main() {
  late AddNewTaskTransaction addNewTaskTransaction;
  late MockTaskRepository mockTaskRepository;
  late List<TaskEntity> tasks;
  late TaskRequest request;
  late TaskEntity task;
  // exception
  late TypeMissmatch typeMissmatch;
  late HiveException hiveException;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    addNewTaskTransaction = AddNewTaskTransaction(mockTaskRepository);
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
    request = TaskRequest(
      id: 'id',
      title: 'Hi',
      desc: 'desc',
      isCompleted: false,
      createTime: '239483',
      category: TaskCategory.personal,
    );
    task = TaskEntity(
      id: 'id',
      title: 'Hi',
      desc: 'desc',
      isCompleted: false,
      createTime: '239483',
      category: TaskCategory.personal,
    );
    typeMissmatch = TypeMissmatch();
    hiveException = HiveException();
  });

  group('add new task transaction', () {
    test('should return List<TaskEntity>', () async {
      when(mockTaskRepository.addNewTask(any))
          .thenAnswer((_) async => Right(tasks));

      var result = await addNewTaskTransaction.call(request);
      verify(mockTaskRepository.addNewTask(task));
      expect(result, Right(tasks));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return TypeMissmatch Exception.', () async {
      when(mockTaskRepository.addNewTask(any))
          .thenAnswer((_) async => Left(typeMissmatch));

      var result = await addNewTaskTransaction.call(request);
      verify(mockTaskRepository.addNewTask(task));
      expect(result, Left(typeMissmatch));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return HiveException.', () async {
      when(mockTaskRepository.addNewTask(any))
          .thenAnswer((_) async => Left(hiveException));

      var result = await addNewTaskTransaction.call(request);
      verify(mockTaskRepository.addNewTask(task));
      expect(result, Left(hiveException));
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
