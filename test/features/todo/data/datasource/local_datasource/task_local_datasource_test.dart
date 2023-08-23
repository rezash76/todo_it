import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_test/features/todo/data/datasource/local_datasource/task_local_datasource.dart';
import 'package:todo_test/features/todo/data/model/hive/hive_task.dart';
import 'package:todo_test/features/todo/data/model/task_dto.dart';

import 'mock_db_provider.mocks.dart';

void main() {
  late MockDBProvider mockDBProvider;
  late TaskLocalDatasourceImpl taskLocalDatasourceImpl;
  late Map<dynamic, dynamic> asd;
  late List<TaskDTO> tasks;

  setUp(() {
    mockDBProvider = MockDBProvider();
    taskLocalDatasourceImpl = TaskLocalDatasourceImpl(mockDBProvider);
    asd = {
      0: HiveTask('title', 'desc', true),
    };
    tasks = [
      TaskDTO('title', 'desc', true),
      TaskDTO('title', 'desc', true),
      TaskDTO('title', 'desc', true),
    ];
  });

  group('get all tasks', () {
    // test('-should return TaskDTO.', () {
    //   when(mockDBProvider.getAll()).thenAnswer((_) => asd);

    //   final result = taskLocalDatasourceImpl.getAllTasks();
    //   verify(mockDBProvider.getAll());
    //   expect(result, tasks);
    //   verifyNoMoreInteractions(mockDBProvider);
    // });
  });
}
