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
  late Map<dynamic, dynamic> hiveMap;
  late List<TaskDTO> tasks;

  setUp(() {
    mockDBProvider = MockDBProvider();
    taskLocalDatasourceImpl = TaskLocalDatasourceImpl(mockDBProvider);
    hiveMap = {
      0: HiveTask('', 'title', 'desc', true),
    };
    tasks = [
      TaskDTO(
        id: 'id',
        title: 'title',
        desc: 'desc',
        isCompleted: false,
      ),
    ];
  });

  group('get all tasks', () {
    // test('-should return TaskDTO.', () {
    //   when(mockDBProvider.getAll()).thenAnswer((_) => hiveMap);

    //   final result = taskLocalDatasourceImpl.getAllTasks();
    //   verify(mockDBProvider.getAll());
    //   expect(result, tasks);
    //   verifyNoMoreInteractions(mockDBProvider);
    // });
  });
}
