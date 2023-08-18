import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/features/todo/domain/entity/task_entity.dart';
import 'package:todo_test/features/todo/domain/transaction/update_task_transaction.dart';
import 'package:todo_test/features/todo/domain/value_object/task_request.dart';
import 'package:todo_test/features/todo/domain/value_object/updat_task_request.dart';

import 'add_new_task_transaction_test.mocks.dart';

void main() {
  late MockTaskRepository mockTaskRepository;
  late UpdateTaskTransaction deleteTaskTransaction;
  List<TaskEntity> tasks = [
    TaskEntity('asq3d', 'asef', false),
    TaskEntity('aedwsd', 'asef', true),
    TaskEntity('aseesfd', 'asef', true),
    TaskEntity('asegd', 'asef', false),
  ];

  final taskReq = TaskRequest('title', 'desc', true);
  var request = UpdateTaskRequest(taskReq, 4);

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    deleteTaskTransaction = UpdateTaskTransaction(mockTaskRepository);
  });

  group('Update tasks', () {
    test('should return List<TaskEntity>', () async {
      when(mockTaskRepository.updateTask(any))
          .thenAnswer((_) async => Right(tasks));

      var result = await deleteTaskTransaction.call(request);
      verify(mockTaskRepository.updateTask(request));
      expect(result, Right(tasks));
      verifyNoMoreInteractions(mockTaskRepository);
    });
  });
}
