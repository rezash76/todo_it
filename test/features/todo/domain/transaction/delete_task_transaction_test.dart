import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/transaction/delete_task_transaction.dart';

import 'add_new_task_transaction_test.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late DeleteTaskTransaction deleteTaskTransaction;
  List<TaskEntity> tasks = [
    TaskEntity('as3d', 'asef', false),
    TaskEntity('aewsd', 'asef', true),
    TaskEntity('asesfd', 'asef', true),
    TaskEntity('asgd', 'asef', false),
  ];

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    deleteTaskTransaction = DeleteTaskTransaction(mockTaskRepository);
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
  });
}
